//
//  AppStoreSearchDomain.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/11/25.
//

import Foundation

struct AppStoreSearchDomain {
    let results: [AppStoreSearchResultDomain]
}

/// 앱 스토어에서 검색된 결과 항목을 나타내는 Entity입니다.
/// API 응답의 개별 앱 정보를 저장합니다.
struct AppStoreSearchResultDomain {
    // 앱의 스크린샷 URL 목록
    let screenshotUrls: [String]
    
    // 앱 아이콘 (100x100)
    let appIcon100: String
    // 앱 아이콘 (512x512)
    let appIcon512: String

    // 평균 사용자 평점
    let averageUserRating: Double
    // 총 사용자 평가 수
    let userRatingCount: Int
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

    // 앱 출시일
    let releaseDate: Date?
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
}

extension AppStoreSearchResultDomain {
    func toViewModel() -> AppStoreSearchResultViewModel {
        return AppStoreSearchResultViewModel(
            screenshotUrls: screenshotUrls,
            appIcon100: appIcon100,
            appIcon512: appIcon512,
            averageUserRating: averageUserRating,
            userRatingCountString: formatNumber(userRatingCount),
            formattedPrice: formattedPrice,
            contentAdvisoryRating: contentAdvisoryRating,
            appName: appName,
            appId: appId,
            deveoplerId: deveoplerId,
            developerName: developerName,
            genres: genres,
            genreIds: genreIds,
            primaryGenreName: primaryGenreName,
            primaryGenreId: primaryGenreId,
            price: price,
            releaseDate: releaseDate?.toPassedString(),
            sellerUrl: sellerUrl,
            releaseNotes: releaseNotes,
            version: version,
            currency: currency,
            description: description,
            minimumOsVersion: minimumOsVersion,
            isGameCenterEnabled: isGameCenterEnabled)
    }
    
    private func formatNumber(_ number: Int) -> String {
        switch number {
        case ..<1_000:
            return "\(number)"
        case 1_000..<10_000:
            let formatted = Double(number) / 1_000
            return String(format: "%.1f 천", formatted)
        case 10_000..<100_000:
            let formatted = Double(number) / 10_000
            return String(format: "%.1f 만", formatted)
        default:
            return "\(number / 10_000) 만"
        }
    }
}
