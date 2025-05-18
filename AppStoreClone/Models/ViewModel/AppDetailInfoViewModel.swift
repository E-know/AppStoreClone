//
//  AppDetailInfoViewModel.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/17/25.
//

import Foundation

struct AppDetailInfoViewModel {
    let appName: String
    let appIcon: URL?
    let appStoreURL: URL?
    let sellerUrl: URL?
    
    let averageUserRating: Double
    let averageUserRatingText: String
    let userRatingCountText: String
    
    let genre: String
    let contentAdvisorRating: String
    let developerName: String
    
    let appVersion: String
    let releaseNotes: String
    let releaseDateText: String
    
    let screenshots: [URL?]
    
    let appDescription: String
    
    let downloadStatus: DownloadStatus
}
