//
//  AppInfoCellView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/4/25.
//

import SwiftUI

struct AppInfoCellView: View {
    var body: some View {
        VStack {
            AppInfoView()
            
            Spacer().frame(height: 14)
            
            AppSubInfoView()
        }
    }
    
    // MARK: AppInfoView
    private func AppInfoView() -> some View {
        HStack {
            Image("kakaoBank")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Spacer().frame(width: 10)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("카카오뱅크")
                    .font(.system(size: 12, weight: .semibold))
                
                Text("금융을 바꾸다 생활을 바꾸다")
                    .font(.system(size: 11))
                    .foregroundStyle(Color.subGray)
            }
            
            Spacer()
            
            Image(systemName: "arrow.down.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)
                .foregroundStyle(Color.downloadIcon)
        }
    }
    
    // MARK: AppSubInfoView
    private func AppSubInfoView() -> some View {
        ZStack {
            /// 왼쪽 셀
            HStack {
                RatingStarView()
                Spacer().frame(width: 2)
                Text("1.3 만")
                    .font(.system(size: 11, weight: .semibold))
                
                Spacer()
            }
            
            /// 가운데 셀
            HStack {
                Spacer()
                
                Image(systemName: "person.crop.square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
                Spacer().frame(width: 5)
                Text("KakaoBank Corp.")
                    .font(.system(size: 11, weight: .semibold))
                
                Spacer()
            }
            /// 오른쪽 셀
            HStack {
                Spacer()
                RankView()
            }
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
            
            Text("금융")
                .font(.system(size: 11, weight: .semibold))
        }
    }
    
    
    // MARK: AppScreenShotView
    private func AppScreenShotView() -> some View {
       Text("공사중")
    }
}

#Preview {
    AppInfoCellView()
}
