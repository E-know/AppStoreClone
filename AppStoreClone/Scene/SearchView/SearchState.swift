//
//  SearchState.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/11/25.
//

import SwiftUI

@Observable
final class SearchState: SearchModelStateProtocol, SearchModelActionsProtocol {
    var textTerm: String = ""
    var searchable: Bool = false
    var goScrollTop: Bool = false
    
    var appInfo: [AppStoreSearchResultViewModel]?
    var navigationPath: [SearchNavigationPath] = []

    
    func setSearchBarTerm(text: String?) {
        textTerm = text ?? ""
    }
    
    func setSearchable(_ value: Bool) {
        self.searchable = value
    }
    
    func setNavigationPath(_ path: [SearchNavigationPath]) {
        self.navigationPath = path
    }
    
    func presentSearchApp(_ response: SearchModel.SearchApp.Response) {
        self.appInfo = response.appInfo.map { $0.toViewModel() }
        goScrollTop.toggle()
    }
    
    func presentGoNavigation(_ response: SearchModel.GoNavigation.Response) {
        self.navigationPath.append(response.path)
    }
    
    func presentDownloadApp(_ response: SearchModel.DownloadApp.Response) {
        withAnimation {
            self.appInfo?[response.index].downloadStatus = .downloading(percent: response.percent)
        }
    }
    
    func presentDownloadAppComplete(_ response: SearchModel.DownloadAppComplete.Response) {
        self.appInfo?[response.index].downloadStatus = .installed
    }
    
    func presentStopDownloadApp(_ response: SearchModel.StopDownloadApp.Response) {
        self.appInfo?[response.index].downloadStatus = .notInstalled
    }
    
    func presentOpenApp(_ response: SearchModel.OpenApp.Response) {
        Task { @MainActor in
            UIApplication.shared.open(response.appURL)
        }
    }
}
