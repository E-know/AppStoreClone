//
//  AppInfoDetailMiddleView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/5/25.
//

import SwiftUI

struct AppInfoDetailMiddleView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 0) {
                Rectangle().frame(height: 0.4)
                
                HStack(spacing: 0) {
                    RatingView()
                        .frame(minWidth : 105)
                    
                    Rectangle().frame(width: 0.4, height: 31.33)
                        .foregroundStyle(Color.subGrayLight)
                    
                    AgeView()
                        .frame(minWidth: 105)
                    
                    Rectangle().frame(width: 0.4, height: 31.33)
                        .foregroundStyle(Color.subGrayLight)
                    
                    CategoryView()
                        .frame(minWidth: 105)
                    
                    Rectangle().frame(width: 0.4, height: 31.33)
                        .foregroundStyle(Color.subGrayLight)
                    
                    DeveloperView()
                        .frame(minWidth: 105, maxWidth: .infinity)
                    
                    Rectangle().frame(width: 0.4, height: 31.33)
                        .foregroundStyle(Color.subGrayLight)
                    
                    LanguageView()
                        .frame(minWidth : 105)
                }
                
                Rectangle().frame(height: 0.4)
            }
            .padding(.horizontal)
        }
    }
    
    private func RatingView() -> some View {
        VStack(spacing: 0) {
            Text("1.3만개의 평가")
                .font(11)
                .padding(.top, 14)
                .padding(.bottom, 6)
                .foregroundStyle(Color.subGrayLight)
            
            Text("3.3")
                .font(20, .bold)
                .padding(.bottom, 4)
                .foregroundStyle(Color.subGray)
            
            HStack(spacing: 2) {
                ForEach(0..<5) { _ in
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                }
                .foregroundStyle(Color.subGray)
            }
            .padding(.bottom, 12)
        }
    }
    
    private func AgeView() -> some View {
        VStack(spacing: 0) {
            Text("연령")
                .font(11)
                .foregroundStyle(Color.subGrayLight)
                .padding(.bottom, 6)
            
            Text("4+")
                .font(20, .bold)
                .foregroundStyle(Color.subGray)
                .padding(.bottom, 3)
            
            Text("세")
                .font(12)
                .foregroundStyle(Color.subGray)
        }
        
    }
    
    private func CategoryView() -> some View {
        VStack(spacing: 0) {
            Text("차트")
                .foregroundStyle(Color.subGrayLight)
                .font(11)
                .padding(.bottom, 6)
            
            Text("#11")
                .foregroundStyle(Color.subGray)
                .font(20, .bold)
                .padding(.bottom, 3)
            
            Text("금융")
                .foregroundStyle(Color.subGrayLight)
                .font(11)
        }
    }
    
    private func DeveloperView() -> some View {
        VStack(spacing: 6) {
            Text("개발자")
                .foregroundStyle(Color.subGrayLight)
                .font(11)
            
            Image(systemName: "person.crop.square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 22, height: 22)
                .foregroundStyle(Color.subGray)
            
            Text("KakaoBank Corp.")
                .font(11)
                .lineLimit(nil)
                .padding(.horizontal, 8)
                .foregroundStyle(Color.subGray)
        }
    }
    
    private func LanguageView() -> some View {
        VStack(spacing: 0) {
            Text("언어")
                .foregroundStyle(Color.gray)
                .font(11)
                .padding(.bottom, 6)
            
            Text("KO")
                .font(20, .bold)
                .foregroundStyle(Color.gray)
                .padding(.bottom, 4)
            
            Text("한국어")
                .foregroundStyle(Color.gray)
                .font(12)
        }
    }
}

#Preview {
    AppInfoDetailMiddleView()
}
