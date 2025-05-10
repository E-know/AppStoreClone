//
//  AppInfoDetailView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/5/25.
//

import SwiftUI

struct AppInfoDetailView: View {
    var body: some View {
        ScrollView {
            VStack {
                TopInfoView()
                    .padding()
                
                AppInfoDetailMiddleView()
                    .padding(.bottom, 11)
                
                AppInfoNewUpdatesView()
                    .padding(.bottom, 34)
                
                AppScreenShotView()
                    .padding(.bottom, 20)
                
                AppIntroductView()
                    .padding(.bottom, 25)
                
                RatingAndReviewView()
                    .padding(.bottom, 38)
                
                PrivacyInfoView()
                
                Spacer()
            }
        }
    }
    
    private func TopInfoView() -> some View {
        HStack(spacing: 16) {
            Image("kakaoBank")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 118, height: 118)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading) {
                Text("카카오뱅크")
                    .font(.system(size: 19))
                
                Spacer().frame(height: 1)
                
                Text("금융을 바꾸다 생황을 바꾸다")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.subGray)
                
                Spacer()
                
                HStack {
                    Button(action: { print("받기") }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 75, height: 32)
                                .foregroundStyle(Color.blue)
                            
                            Text("열기")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 13, weight: .bold))
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: { print("Share") }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(Color.blue)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18)
                    }
                }
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        AppInfoDetailView()
    }
}
