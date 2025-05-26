//
//  AppInfoDetailMiddleView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/5/25.
//

import SwiftUI

struct AppInfoDetailMiddleView: View {
    private let averageUserRating: Double
    private let averageUserRatingText: String
    private let userRatingCountText: String
    private let contentAdvisoryRating: String
    private let gerne: String
    private let developerName: String
    
    init(averageUserRating: Double, averageUserRatingText: String, userRatingCountText: String, contentAdvisoryRating: String, gerne: String, developerName: String) {
        self.averageUserRating = averageUserRating
        self.averageUserRatingText = averageUserRatingText
        self.userRatingCountText = userRatingCountText
        self.contentAdvisoryRating = contentAdvisoryRating
        self.gerne = gerne
        self.developerName = developerName
    }
    
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
            Text("\(userRatingCountText)개의 평가")
                .font(11)
                .padding(.top, 14)
                .padding(.bottom, 6)
                .foregroundStyle(Color.subGrayLight)
            
            Text(averageUserRatingText)
                .font(20, .bold)
                .padding(.bottom, 4)
                .foregroundStyle(Color.subGray)
            
            RatingStarView(starSize: 12, spacing: 2, rating: averageUserRating, color: .subGray)
                .padding(.bottom, 12)
        }
    }
    
    private func AgeView() -> some View {
        VStack(spacing: 0) {
            Text("연령")
                .font(11)
                .foregroundStyle(Color.subGrayLight)
                .padding(.bottom, 6)
            
            Text(contentAdvisoryRating)
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
            
            Text("#\(Int.random(in: 1...50))")
                .foregroundStyle(Color.subGray)
                .font(20, .bold)
                .padding(.bottom, 3)
            
            Text(gerne)
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
            
            Text(developerName)
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
    let rawData = AppStoreSearchAPI.search(term: "Test").sampleData
    let entity = try? JSONDecoder().decode(AppStoreSearchEntity.self, from: rawData)
    let domain = entity?.toDomain()
    guard let viewModel = domain?.results.first?.toDetailViewModel() else {
        return Text("Error")
    }
    
    return AppInfoDetailMiddleView(
        averageUserRating: viewModel.averageUserRating,
        averageUserRatingText: viewModel.averageUserRatingText,
        userRatingCountText: viewModel.userRatingCountText,
        contentAdvisoryRating: viewModel.contentAdvisorRating,
        gerne: viewModel.genre,
        developerName: viewModel.developerName
    )
}
