//
//  SearchModel.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/18/25.
//

import Foundation

enum SearchModel {
    enum ViewStatus {
        case `init`
        case waitNetwork
        case searched([AppStoreSearchResultDomain])
    }
    
    enum SearchApp {
        struct Request {
            let term: String
        }
        
        struct Response {
            let appInfo: [AppStoreSearchResultDomain]
        }
    }
    
    enum GoNavigation {
        struct Request {
            let appID: Int
        }
        
        struct Response {
            let path: SearchNavigationPath
        }
    }
    
    enum DownloadApp {
        struct Request {
            let appID: Int
        }
        
        struct Response {
            let index: Int
            let percent: Float
        }
    }
    
    enum DownloadAppComplete {
        struct Response {
            let index: Int
        }
    }
    
    enum StopDownloadApp {
        struct Request {
            let appID: Int
        }
        
        struct Response {
            let index: Int
        }
    }
    
    enum OpenApp {
        struct Request {
            let appID: Int
        }
        
        struct Response {
            let appURL: URL
        }
    }
}
