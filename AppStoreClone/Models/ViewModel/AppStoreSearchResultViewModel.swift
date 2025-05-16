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
    
    // 앱 아이콘 (100x100)
    let appIcon100: URL?
    // 앱 아이콘 (512x512)
    let appIcon512: URL?

    // 평균 사용자 평점
    let averageUserRating: Double
    // 총 사용자 평가 수 (1.3천 / 803 / 108만 등)
    let userRatingCountString: String
    // 표시되는 가격
    let formattedPrice: String
    // 콘텐츠 등급 (예: 4+, 12+)
    let contentAdvisoryRating: String

    // 앱 이름
    let appName: String
    // 앱 고유 식별자
    let appId: Int
    // 개발자 고유 식별자
    let deveoplerId: Int
    // 개발자 이름
    let developerName: String

    // 앱 장르 (예: "게임", "교육")
    let genres: [String]
    // 장르 ID 목록
    let genreIds: [String]
    // 주요 장르 이름
    let primaryGenreName: String
    // 주요 장르 ID
    let primaryGenreId: String
    // 앱 가격 (숫자형)
    let price: Int

    // 앱 출시일 ( 1달 전, 3주 전 등)
    let releaseDate: String?
    // 개발자 웹사이트 URL
    let sellerUrl: String?

    // 앱의 최근 릴리즈 노트
    let releaseNotes: String
    // 앱 버전
    let version: String
    // 통화 코드 (예: KRW, USD)
    let currency: String

    // 앱 설명
    let description: String

    // 최소 지원 iOS 버전
    let minimumOsVersion: String

    // 게임 센터 지원 여부
    let isGameCenterEnabled: Bool
    
    var isDownloaded: Bool = false
    
    let appStoreURL: URL?
}
