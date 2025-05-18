//
//  RatingAndReviewView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/10/25.
//

import SwiftUI

struct RatingAndReviewView: View {
    private let horizontalPadding: CGFloat = 20
    private let averageUserRating: Double
    private let averageUserRatingText: String
    private let userRatingCountText: String
    
    init(averageUserRating: Double, averageUserRatingText: String, userRatingCountText: String) {
        self.averageUserRating = averageUserRating
        self.averageUserRatingText = averageUserRatingText
        self.userRatingCountText = userRatingCountText
    }

    var body: some View {
        VStack {
            ReviewSummaryView()
                .padding(.bottom, 8)
            
            MostHelpReview()
                .padding(.bottom, 24)
            
            TapToRateView()
        }
    }
    
    @ViewBuilder
    private func ReviewSummaryView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("평가 및 리뷰")
                    .font(19, .bold)
                    .padding(.trailing, 3)
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.subGray)
                    .frame(height: 14)
            }
            
            HStack(alignment: .center) {
                Text(averageUserRatingText)
                    .font(70, .bold)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    RatingStarView(
                        starSize: 16,
                        spacing: 6,
                        rating: averageUserRating,
                        color: .black
                    )
                    
                    Text("\(userRatingCountText)개의 평가")
                        .font(14)
                        .foregroundStyle(Color.subGray)
                }
            }
        }
        .padding(.horizontal, horizontalPadding)
    }
    
    @ViewBuilder
    private func MostHelpReview() -> some View {
        VStack(alignment: .leading) {
            
            Text("가장 도움이 되는 리뷰")
                .font(14)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal) {
                HStack(spacing: 14) {
                    ForEach(0..<5) { _ in
                        ReviewItem()
                            .shadow(color: Color.subGray, radius: 8, x: 2, y: 4)
                            .containerRelativeFrame(.horizontal) { length, _ in
                                let width = length - self.horizontalPadding * 2
                                return width < 0 ? 0 : width
                            }
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.never)
        }
    }
    
    @ViewBuilder
    private func ReviewItem() -> some View {
        VStack(alignment: .leading) {
            Text("엄청 엄청 잘쓰고 있어요")
                .font(14)
                .padding(.bottom, 14)
            
            HStack {
                HStack(spacing: 3) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12, height: 12)
                    }
                }
                
                Text("2월 23일・유우우저닉네임")
                    .font(12)
                    .foregroundStyle(Color.subGray)
                
                Spacer()
            }
            .padding(.bottom, 8)
            
            
            
            Text("""
                하하호호 이건 몇줄까지
                될까요?? 알아 맞춰보세요
                딩동댕동
                척척박사님
                알아맞춰보세요
                """)
            .font(12)
            .lineLimit(5)
            .multilineTextAlignment(.leading)
            .foregroundStyle(Color.subGray)
        }
        .padding(20)
        .background {
            Color.white
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        
    }
    
    @ViewBuilder
    private func TapToRateView() -> some View {
        VStack {
            Text("탭하여 평가하기")
                .font(14)
                .padding(.bottom, 10)
            
            Button(action: {
                print("Tap Star")
            }) {
                HStack(spacing: 16) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star")
                    }
                }
            }
            
            Spacer().frame(height: 18)
            
            HStack(spacing: 11) {
                Button(action: {
                    print("리뷰 작성")
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(Color.subGrayLight)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 13, height: 13)
                            
                            Text("리뷰 작성")
                                .font(14)
                        }
                    }
                }
                .frame(height: 50)
                
                Button(action: {
                    print("앱 지원")
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(Color.subGrayLight)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 11, height: 11)
                            
                            Text("앱 지원")
                                .font(14)
                        }
                    }
                }
                .frame(height: 50)
            }
        }
        .padding(.horizontal, horizontalPadding)
    }
}

#Preview {
    RatingAndReviewView(averageUserRating: 4.7, averageUserRatingText: "4.7", userRatingCountText: "15만개")
}
