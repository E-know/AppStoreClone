//
//  AppInfoDetailIntent.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/16/25.
//

import Combine
import Foundation

protocol AppInfoDetailActionProtocol: AnyObject {
    func presentAppInfo(_ response: AppInfoDetailModel.PresentAppInfo.Response)
    func presentDownloading(_ response: AppInfoDetailModel.Downloading.Response)
    func presentCompleteDownLoad(_ response: AppInfoDetailModel.DownloadComplete.Response)
    func presentOpenApp(_ response: AppInfoDetailModel.OpenApp.Response)
    func presentStopDownload(_ response: AppInfoDetailModel.StopDownload.Response)
}


final class AppInfoDetailIntent: AppInfoDetailIntentProtocol, @unchecked Sendable {
    weak var presenter: AppInfoDetailActionProtocol?
    var appInfo: AppStoreSearchResultDomain?
    var appDownloadPercent: Float = 0
    var timerCancellable: AnyCancellable?
    
    init(_ action: AppInfoDetailActionProtocol) {
        self.presenter = action
    }
    
    deinit {
        print(#file, "Deinit")
    }
    
    func requestAppInfo(_ request: AppInfoDetailModel.PresentAppInfo.Request) {
        self.appInfo = request.appInfo
        
        Task {
            let viewModel = request.appInfo.toViewModel()
            presenter?.presentAppInfo(.init(viewModel: viewModel))
        }
    }
    
    func requestDownload(_ request: AppInfoDetailModel.TabDownLoad.Request) {
        Task { [weak self] in
            self?.presenter?.presentDownloading(.init(percent: 0.0))
            
            self?.timerCancellable = Timer
                .publish(every: 1.0, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    guard let self else { return }
                    let increment = Float.random(in: 0.05...0.3)
                    self.appDownloadPercent += increment
                    if self.appDownloadPercent >= 1.0 {
                        self.appDownloadPercent = 1.0
                        self.timerCancellable?.cancel()
                        self.presenter?.presentCompleteDownLoad(.init())
                    } else {
                        self.presenter?.presentDownloading(.init(percent: self.appDownloadPercent))
                    }
                }
        }
    }
    
    func requestOpenApp(_ request: AppInfoDetailModel.OpenApp.Request) {
        guard
            let urlString = appInfo?.sellerUrl,
            let url = URL(string: urlString)
        else { return }
        
        Task { [weak self] in
            guard let self else { return }
            
            presenter?.presentOpenApp(.init(url: url))
        }
    }
    
    func requestStopDownload(_ request: AppInfoDetailModel.StopDownload.Request) {
        timerCancellable?.cancel()
        appDownloadPercent = 0
        presenter?.presentStopDownload(.init())
    }
}


enum AppInfoDetailModel {
    enum PresentAppInfo {
        struct Request {
            let appInfo: AppStoreSearchResultDomain
        }
        
        struct Response {
            let viewModel: AppStoreSearchResultViewModel
        }
    }
    
    enum TabDownLoad {
        struct Request {}
    }
    
    enum Downloading {
        struct Response {
            let percent: Float
        }
    }
    
    enum DownloadComplete {
        struct Response {}
    }
    
    enum StopDownload {
        struct Request {}
        
        struct Response {}
    }
    
    enum OpenApp {
        struct Request {}
        
        struct Response {
            let url: URL
        }
    }
    
    enum Share {
        struct Request {}
        
        struct Response {
            let url: URL
        }
    }
}
