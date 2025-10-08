//
//  AppStoreSearchEntity.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/11/25.
//

import Foundation

struct AppStoreSearchEntity: Decodable {
    let results: [AppStoreSearchResultEntity]
    let resultCount: Int
}

/// 앱 스토어에서 검색된 결과 항목을 나타내는 Entity입니다.
/// API 응답의 개별 앱 정보를 저장합니다.
struct AppStoreSearchResultEntity: Decodable {
    // 앱의 스크린샷 URL 목록
    let screenshotUrls: [String]?
    let artworkUrl512: String?

    // 평균 사용자 평점
    let averageUserRating: Double?
    // 검열된 앱 이름
    let trackCensoredName: String?
    // 표시되는 가격
    let formattedPrice: String?
    // 콘텐츠 등급 (예: 4+, 12+)
    let contentAdvisoryRating: String?
    // 현재 버전에 대한 사용자 평가 수
    let userRatingCountForCurrentVersion: Int?

    // 앱 이름
    let trackName: String?
    // 앱 고유 식별자
    let trackId: Int?
    // 개발자 이름
    let artistName: String?

    // 앱 장르 (예: "게임", "교육")
    let genres: [String]?
    // 장르 ID 목록
    let genreIds: [String]?
    // 주요 장르 이름
    let primaryGenreName: String?
    // 주요 장르 ID
    let primaryGenreId: Int?
    // 앱 가격 (숫자형)
    let price: Int?

    // 앱 출시일 (ISO 8601 형식)
    let releaseDate: String?
    // 개발자 웹사이트 URL
    let sellerUrl: String?
    
    // 앱의 최근 릴리즈 노트
    let releaseNotes: String?
    // 앱 버전
    let version: String?
    // 통화 코드 (예: KRW, USD)
    let currency: String?

    // 앱 설명
    let description: String?

    // 총 사용자 평가 수
    let userRatingCount: Int?

    func toDomain() -> AppStoreSearchResultDomain? {
        guard
            let releaseDate,
            let formattedDate = Date.fromISO8601String(releaseDate),
            let screenshotURLs = self.screenshotUrls?.map({ URL(string: $0) }),
            let artworkUrl512,
            let appIconURL = URL(string: artworkUrl512),
            let averageUserRating,
            let userRatingCount,
            let formattedPrice,
            let contentAdvisoryRating, let trackId,
            let trackName, let artistName, let primaryGenreName,
            let price,
            let sellerUrl, let sellerUrl = URL(string: sellerUrl),
            let releaseNotes, let version,
            let currency, let description
        else { return nil }

        return AppStoreSearchResultDomain(
            screenshotUrls: screenshotURLs,
            appIconURL: appIconURL,
            averageUserRating: averageUserRating,
            userRatingCount: userRatingCount,
            formattedPrice: formattedPrice,
            contentAdvisoryRating: contentAdvisoryRating,
            appName: trackName,
            appId: trackId,
            developerName: artistName,
            primaryGenreName: primaryGenreName,
            price: price,
            releaseDate: formattedDate,
            sellerUrl: sellerUrl,
            releaseNotes: releaseNotes,
            version: version,
            currency: currency,
            description: description
        )
    }
}


extension AppStoreSearchEntity {
    func toDomain() -> AppStoreSearchDomain {
        let domain = self.results.compactMap { $0.toDomain() }
        return AppStoreSearchDomain(
            results: domain
        )
    }
}
