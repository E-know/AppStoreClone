//
//  AppIntroductView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/10/25.
//

import SwiftUI

struct AppIntroductView: View {
    private let textFontSize: CGFloat = 12
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("""
                    대한민국에서 가장 빠른 길 안내하는 카카오맵!
                    가장 빠른 길찾기는 물론 맛집, 주변추천 등
                    당신이 기대하는 길찾기의 모든것을 만나보세요!
                    """)
                    .font(textFontSize)
                    .lineSpacing(textFontSize * 0.7)
                }
                
                Spacer()
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        print("더보기")
                    }) {
                        Text("더 보기")
                            .font(textFontSize)
                    }
                }
            }
            
            Button(action: {
                print("KakaoBank Corp.")
            }) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("KakaoBank Corp.")
                            .font(textFontSize)
                            .padding(.bottom, 2)
                        
                        Text("개발자")
                            .foregroundStyle(Color.subGray)
                            .font(textFontSize)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 15)
                        .foregroundStyle(Color.subGray)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AppIntroductView()
}
