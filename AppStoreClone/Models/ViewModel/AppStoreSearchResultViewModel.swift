//
//  AppStoreSearchResultViewModel.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/11/25.
//

import Foundation

struct AppStoreSearchResultViewModel: Identifiable, Hashable {
    var id: Int {
        self.appId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.appId)
    }
    
    // 앱의 스크린샷 URL 목록
    let screenshotUrls: [URL?]
    let appIcon: URL?

    // 평균 사용자 평점
    let averageUserRating: Double
    // 평균 사용자 평점 텍스트
    let averageuserRatingText: String
    // 총 사용자 평가 수 (1.3천 / 803 / 108만 등)
    let userRatingCountText: String

    // 앱 이름
    let appName: String
    // 앱 고유 식별자
    let appId: Int
    // 개발자 이름
    let developerName: String

    let primaryGenreName: String
    let rank: String
    let downloadButtonText: String
    
    var downloadStatus: DownloadStatus
}
