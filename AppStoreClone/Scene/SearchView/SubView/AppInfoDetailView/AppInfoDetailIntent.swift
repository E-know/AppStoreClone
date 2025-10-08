//
//  AppInfoDetailIntent.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/16/25.
//

import Combine
import Foundation

protocol AppInfoDetailActionProtocol: AnyObject {
    func setShowFullScreenshot(_ showFullScreenshot: Bool)
    
    func presentAppInfo(_ response: AppInfoDetailModel.PresentAppInfo.Response)
    func presentDownloading(_ response: AppInfoDetailModel.Downloading.Response)
    func presentCompleteDownLoad(_ response: AppInfoDetailModel.DownloadComplete.Response)
    func presentOpenApp(_ response: AppInfoDetailModel.OpenApp.Response)
    func presentStopDownload(_ response: AppInfoDetailModel.StopDownload.Response)
    func presentFullScreenshot(_ response: AppInfoDetailModel.FullScreenshot.Response)
}


final class AppInfoDetailIntent: AppInfoDetailIntentProtocol {
    weak var presenter: AppInfoDetailActionProtocol?
    var appInfo: AppStoreSearchResultDomain?
    var appDownloadPercent: Float = 0
    var timerCancellable: AnyCancellable?
    
    init(_ presenter: AppInfoDetailActionProtocol) {
        self.presenter = presenter
    }
    
    deinit {
        print(#file, "Deinit")
    }
    
    func setShowFullScreenshot(_ showFullScreenshot: Bool) {
        presenter?.setShowFullScreenshot(showFullScreenshot)
    }
    
    func requestAppInfo(_ request: AppInfoDetailModel.PresentAppInfo.Request) {
        self.appInfo = request.appInfo
        
        Task {
            let viewModel = request.appInfo.toDetailViewModel()
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
        guard let url = appInfo?.sellerUrl else { return }
        
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
    
    func requestTapDeveloperButton(_ request: AppInfoDetailModel.TapDeveloperButton.Request) {
        print("It is run in Intent hahaha")
    }
    
    func requestFullScreenshot(_ request: AppInfoDetailModel.FullScreenshot.Request) {
        presenter?.presentFullScreenshot(.init(index: request.index))
    }
}
