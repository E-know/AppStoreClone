//
//  AppInfoDetailState.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/16/25.
//

import SwiftUI

enum DownloadStatus: Hashable {
    case notInstalled
    case downloading(percent: Float)
    case installed
}

@Observable
final class AppInfoDetailState: AppInfoDetailActionProtocol, AppInfoDetailStateProtocol {
    var infoViewModel: AppDetailInfoViewModel?
    var showFullScreenshot: Bool = false
    var fullScreenInitIndex: Int = 0
    
    func setShowFullScreenshot(_ showFullScreenshot: Bool) {
        self.showFullScreenshot = showFullScreenshot
    }
    
    func presentAppInfo(_ response: AppInfoDetailModel.PresentAppInfo.Response) {
        self.infoViewModel = response.viewModel
    }

    func presentDownloading(_ response: AppInfoDetailModel.Downloading.Response) {
        withAnimation {
            infoViewModel?.downloadStatus = .downloading(percent: response.percent)
        }
    }
    
    func presentCompleteDownLoad(_ response: AppInfoDetailModel.DownloadComplete.Response) {
        infoViewModel?.downloadStatus = .installed
    }
    
    func presentOpenApp(_ response: AppInfoDetailModel.OpenApp.Response) {
        Task { @MainActor in
            UIApplication.shared.open(response.url)
        }
    }
    
    func presentStopDownload(_ response: AppInfoDetailModel.StopDownload.Response) {
        withAnimation {
            infoViewModel?.downloadStatus = .notInstalled
        }
    }

    func presentFullScreenshot(_ response: AppInfoDetailModel.FullScreenshot.Response) {
        fullScreenInitIndex = response.index
        showFullScreenshot.toggle()
    }
}
