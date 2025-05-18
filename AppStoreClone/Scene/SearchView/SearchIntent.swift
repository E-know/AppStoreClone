//
//  SearchIntent.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/11/25.
//

import Combine
import Foundation

protocol SearchModelActionsProtocol: AnyObject {
    func setSearchBarTerm(text: String?)
    func setSearchable(_ value: Bool)
    func setNavigationPath(_ path: [SearchNavigationPath])
    
    func presentSearchApp(_ response: SearchModel.SearchApp.Response)
    func presentGoNavigation(_ response: SearchModel.GoNavigation.Response)
    func presentDownloadApp(_ response: SearchModel.DownloadApp.Response)
    func presentDownloadAppComplete(_ response: SearchModel.DownloadAppComplete.Response)
    func presentStopDownloadApp(_ response: SearchModel.StopDownloadApp.Response)
    func presentOpenApp(_ response: SearchModel.OpenApp.Response)
}

final class SearchIntent: SearchIntentProtocol {
    private weak var state: SearchModelActionsProtocol?
    private var appSearchResult: AppStoreSearchDomain?
    private var timerCancellable: [Int: AnyCancellable] = [:]
    private var appDownloadPercent: [Int: Float] = [:]
    
    init(state: SearchModelActionsProtocol) {
        self.state = state
    }
    
    func setSearchBarTerm(_ term: String) {
        state?.setSearchBarTerm(text: term)
    }
    
    func setSearchable(_ value: Bool) {
        state?.setSearchable(value)
    }
    
    func setNavigationPath(_ path: [SearchNavigationPath]) {
        state?.setNavigationPath(path)
    }
    
    
    func requestSearchApp(_ request: SearchModel.SearchApp.Request) {
        Task {
            let worker = AppStoreSearchWorker()
            let domainData = try await worker.search(term: request.term)
            self.appSearchResult = domainData
            
            state?.presentSearchApp(.init(appInfo: domainData.results))
        }
    }
    
    
    func requestGoNavigation(_ request: SearchModel.GoNavigation.Request) {
        Task {
            guard let domain = appSearchResult?.results.filter({ $0.appId == request.appID }).first else { return }
            
            let path = SearchNavigationPath.appDetail(data: domain)
            
            state?.presentGoNavigation(.init(path: path))
        }
    }
    
    
    func requestDownloadApp(_ request: SearchModel.DownloadApp.Request) {
        Task {
            guard let index = appSearchResult?.results.firstIndex(where: { $0.appId == request.appID }) else { return }
            appSearchResult?.results[index].downloadStatus = .downloading(percent: 0)
            state?.presentDownloadApp(.init(index: index, percent: 0))
            
            self.timerCancellable[request.appID]?.cancel()
            self.appDownloadPercent[request.appID] = 0
            self.timerCancellable[request.appID] = Timer
                .publish(every: 1.0, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    guard let self else { return }
                    let increment = Float.random(in: 0.05...0.3)
                    self.appDownloadPercent[request.appID, default: 0] += increment
                    if self.appDownloadPercent[request.appID, default: 0] >= 1.0 {
                        self.appDownloadPercent[request.appID] = 1.0
                        self.timerCancellable[request.appID]?.cancel()
                        
                        appSearchResult?.results[index].downloadStatus = .installed
                        self.state?.presentDownloadAppComplete(.init(index: index))
                    } else if let percent = self.appDownloadPercent[request.appID] {
                        
                        appSearchResult?.results[index].downloadStatus = .downloading(percent: percent)
                        self.state?.presentDownloadApp(.init(index: index, percent: percent))
                    } else {
                        self.timerCancellable[request.appID]?.cancel()
                    }
                }
        }
    }
    
    func requestStopDownloadApp(_ request: SearchModel.StopDownloadApp.Request) {
        Task {
            guard let index = appSearchResult?.results.firstIndex(where: { $0.appId == request.appID }) else { return }
            
            timerCancellable[request.appID]?.cancel()
            
            state?.presentStopDownloadApp(.init(index: index))
        }
    }
    
    func requestOpenApp(_ request: SearchModel.OpenApp.Request) {
        Task {
            guard
                let domain = appSearchResult?.results.filter({ $0.appId == request.appID }).first,
                let sellerUrl = domain.sellerUrl,
                let appURL = URL(string: sellerUrl)
            else { return }
            
            state?.presentOpenApp(.init(appURL: appURL))
        }
    }
}

enum SearchNavigationPath: Hashable {
    case appDetail(data: AppStoreSearchResultDomain)
}
