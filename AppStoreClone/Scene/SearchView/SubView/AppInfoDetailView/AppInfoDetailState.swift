//
//  AppInfoDetailState.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/16/25.
//

import SwiftUI

enum DownloadStatus {
    case notInstalled
    case downloading(percent: Float)
    case installed
}

@Observable
final class AppInfoDetailState: AppInfoDetailActionProtocol, AppInfoDetailStateProtocol {
    var infoViewModel: AppStoreSearchResultViewModel?
    var downloadStatus: DownloadStatus = .notInstalled
    
    func presentAppInfo(_ response: AppInfoDetailModel.PresentAppInfo.Response) {
        self.infoViewModel = response.viewModel
    }

    func presentDownloading(_ response: AppInfoDetailModel.Downloading.Response) {
        withAnimation {
            downloadStatus = .downloading(percent: response.percent)
        }
    }
    
    func presentCompleteDownLoad(_ response: AppInfoDetailModel.DownloadComplete.Response) {
        downloadStatus = .installed
    }
    
    func presentOpenApp(_ response: AppInfoDetailModel.OpenApp.Response) {
        Task { @MainActor in
            UIApplication.shared.open(response.url)
        }
    }
    
    func presentStopDownload(_ response: AppInfoDetailModel.StopDownload.Response) {
        withAnimation {
            downloadStatus = .notInstalled
        }
    }
}
