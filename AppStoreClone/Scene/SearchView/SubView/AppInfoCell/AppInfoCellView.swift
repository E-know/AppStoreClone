//
//  AppInfoCellView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/4/25.
//

import Kingfisher
import SwiftUI

struct AppInfoCellView: View {
    private let appInfo: AppStoreSearchResultViewModel
    weak var intent: SearchIntentProtocol?
    
    init(appInfo: AppStoreSearchResultViewModel, intent: SearchIntentProtocol? = nil) {
        self.appInfo = appInfo
        self.intent = intent
    }
    
    var body: some View {
        VStack(spacing: 14) {
            AppInfoView()
            
            AppSubInfoView()
            
            AppScreenShotView()
        }
    }
    
    // MARK: AppInfoView
    private func AppInfoView() -> some View {
        HStack(spacing: 0) {
            KFImage(appInfo.appIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.subGrayLight, lineWidth: 0.5)
                )
                .padding(.trailing, 10)
            
            
            VStack(alignment: .leading, spacing: 6) {
                Text(appInfo.appName)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundStyle(Color.black)
                    .font(.system(size: 13, weight: .semibold))
                
                Text("")
                    .font(.system(size: 11))
                    .foregroundStyle(Color.subGray)
            }
            
            Spacer()
            
            DownloadButton()
        }
    }
    
    
    // MARK: AppSubInfoView
    private func AppSubInfoView() -> some View {
        HStack(spacing: 0) {
            /// 왼쪽 셀
            RatingStarView(starSize: 9, spacing: 1.3, rating: appInfo.averageUserRating, color: .subGray)
                .padding(.trailing, 2)
            
            Text(appInfo.userRatingCountText)
                .font(.system(size: 11, weight: .semibold))
                
            Spacer()
            
            /// 가운데 셀
            Image(systemName: "person.crop.square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 10, height: 10)
                .padding(.trailing, 5)
            
            Text(appInfo.developerName)
                .font(.system(size: 11, weight: .semibold))
                
            Spacer()
            
            /// 오른쪽 셀
            RankView()
            
        }
        .foregroundStyle(Color.subGray)
    }
    
    
    private func RankView() -> some View {
        HStack {
            Text(appInfo.rank)
                .font(.system(size: 9, weight: .semibold))
                .padding(.vertical, 1)
                .padding(.horizontal, 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.subGray, lineWidth: 1)
                )
                .padding(.trailing, 1)
            
            
            Text(appInfo.primaryGenreName)
                .font(.system(size: 11, weight: .semibold))
        }
    }
    
    
    // MARK: AppScreenShotView
    private func AppScreenShotView() -> some View {
        HStack {
            ForEach(appInfo.screenshotUrls.prefix(3), id: \.self) { url in
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
    
    @ViewBuilder
    private func DownloadButton() -> some View {
        switch appInfo.downloadStatus {
            case .notInstalled:
                Button(action: {
                    intent?.requestDownloadApp(.init(appID: appInfo.appId))
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 75, height: 32)
                            .foregroundStyle(Color.downloadBG)
                        
                        Text(appInfo.downloadButtonText)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(Color.download)
                    }
                }
            case .downloading(let percent):
                Button(action: {
                    intent?.requestStopDownloadApp(.init(appID: appInfo.appId))
                }) {
                    CircularProgressView(progress: percent)
                }
            case .installed:
                Button(action: {
                    intent?.requestOpenApp(.init(appID: appInfo.appId))
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 75, height: 32)
                            .foregroundStyle(Color.downloadBG)
                        
                        Text("열기")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(Color.download)
                    }
                }
        }
    }
}

#Preview {
    let rawData = AppStoreSearchAPI.search(term: "Test").sampleData
    let entity = try? JSONDecoder().decode(AppStoreSearchEntity.self, from: rawData)
    let domain = entity?.toDomain()
    
    
    if let viewModel = domain?.results.first?.toViewModel() {
        AppInfoCellView(appInfo: viewModel)
    } else {
        Text("fail")
    }
}
