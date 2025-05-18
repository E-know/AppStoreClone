//
//  AppInfoDetailModel.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/18/25.
//

import Foundation

enum AppInfoDetailModel {
    enum PresentAppInfo {
        struct Request {
            let appInfo: AppStoreSearchResultDomain
        }
        
        struct Response {
            let viewModel: AppDetailInfoViewModel
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
    
    enum TapDeveloperButton {
        struct Request {}
    }
    
    enum FullScreenshot {
        struct Request {
            let index: Int
        }
        
        struct Response {
            let index: Int
        }
    }
}
