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
    
    init(appInfo: AppStoreSearchResultViewModel) {
        self.appInfo = appInfo
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
            KFImage(URL(string: appInfo.appIcon100))
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
            
            Button(action: {
                print("받기")
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 75, height: 32)
                        .foregroundStyle(Color.downloadBG)
                    
                    Text("받기")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(Color.download)
                }
            }
        }
    }
    
    
    // MARK: AppSubInfoView
    private func AppSubInfoView() -> some View {
        HStack(spacing: 0) {
            /// 왼쪽 셀
            RatingStarView()
                .padding(.trailing, 2)
            
            Text(appInfo.userRatingCountString)
                .font(.system(size: 11, weight: .semibold))
                
            Spacer()
            
            /// 가운데 셀
            Image(systemName: "person.crop.square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 10, height: 10)
            Spacer().frame(width: 5)
            Text(appInfo.developerName)
                .font(.system(size: 11, weight: .semibold))
                
            Spacer()
            
            /// 오른쪽 셀
            RankView()
            
        }
        .foregroundStyle(Color.subGray)
    }
    
    private func RatingStarView() -> some View {
        Rectangle()
            .frame(width: 1.3 * 4 + 9 * 5, height: 9)
            .foregroundStyle(Color.subGray)
            .mask {
                HStack(spacing: 1.3) {
                    ForEach(0..<5, id: \.self) { _ in
                        Image(systemName: "star")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 9, height: 9)
                    }
                }
            }
    }
    
    private func RankView() -> some View {
        HStack {
            Text("#11")
                .font(.system(size: 9, weight: .semibold))
                .padding(.vertical, 1)
                .padding(.horizontal, 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.subGray, lineWidth: 1)
                )
            
            Spacer().frame(width: 2)
            
            Text(appInfo.genres[0])
                .font(.system(size: 11, weight: .semibold))
        }
    }
    
    
    // MARK: AppScreenShotView
    private func AppScreenShotView() -> some View {
        HStack {
            ForEach(appInfo.screenshotUrls.prefix(3), id: \.self) { urlString in
                KFImage(URL(string: urlString))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

//#Preview {
//    AppInfoCellView(appInfo: <#AppStoreSearchResultViewModel#>)
//}
