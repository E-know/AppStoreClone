//
//  AppStoreSearchDomain.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/11/25.
//

import Foundation

struct AppStoreSearchDomain: Hashable, Equatable {
    var results: [AppStoreSearchResultDomain]
}

/// 앱 스토어에서 검색된 결과 항목을 나타내는 Entity입니다.
/// API 응답의 개별 앱 정보를 저장합니다.
struct AppStoreSearchResultDomain: Hashable {
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
    
    var downloadStatus: DownloadStatus = .notInstalled
}

extension AppStoreSearchResultDomain {
    func toViewModel() -> AppStoreSearchResultViewModel {
        return AppStoreSearchResultViewModel(
            screenshotUrls: screenshotUrls.map { URL(string: $0) },
            appIcon: URL(string: appIcon100),
            averageUserRating: averageUserRating,
            averageuserRatingText: String(format: "%.01f", averageUserRating),
            userRatingCountText: formatNumber(userRatingCount),
            appName: appName,
            appId: appId,
            developerName: developerName,
            primaryGenreName: primaryGenreName,
            rank: "#" + String(Int.random(in: 1...50)),
            downloadButtonText: getDownloadButtonText(currency: self.currency, price: self.price),
            downloadStatus: downloadStatus
        )
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
    
    private var appStoreURL: URL? {
        URL(string: "https://apps.apple.com/kr/app/id\(appId)")
    }
    
    private func getDownloadButtonText(currency: String, price: Int) -> String {
        guard price > 0 else { return "받기" }
    
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let formattedPrice = formatter.string(from: NSNumber(value: price)) else { return "받기" }
        
        return switch currency {
            case "USD":
                "$\(formattedPrice)"
            case "KRW":
                "₩\(formattedPrice)"
            default:
                "⁉️\(formattedPrice)"
        }
    }
    
    
    func toDetailViewModel() -> AppDetailInfoViewModel {
        let sellerURL: URL? = if let sellerUrl {
            URL(string: sellerUrl)
        } else {
            nil
        }
        
        return AppDetailInfoViewModel(
            appName: self.appName,
            appIcon: URL(string: appIcon512),
            appStoreURL: appStoreURL,
            sellerUrl: sellerURL,
            averageUserRating: averageUserRating,
            averageUserRatingText: String(format: "%.01f", averageUserRating),
            userRatingCountText: formatNumber(userRatingCount),
            genre: primaryGenreName,
            contentAdvisorRating: contentAdvisoryRating,
            developerName: developerName,
            appVersion: version,
            releaseNotes: releaseNotes,
            releaseDateText: releaseDate?.toPassedString() ?? "",
            screenshots: screenshotUrls.map { URL(string: $0) },
            appDescription: description,
            downloadStatus: downloadStatus
        )
    }
}
