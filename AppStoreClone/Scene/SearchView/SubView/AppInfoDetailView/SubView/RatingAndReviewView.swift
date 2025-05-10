//
//  RatingAndReviewView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/10/25.
//

import SwiftUI

struct RatingAndReviewView: View {
    private let horizontalPadding: CGFloat = 20
    @State private var reviewItemSize: CGFloat = 0
    var body: some View {
        VStack {
            ReviewSummaryView()
                .padding(.bottom, 8)
            
            MostHelpReview()
                .padding(.bottom, 24)
            
            TapToRateView()
        }
        .overlay {
            GeometryReader { geometry in
                Task { @MainActor in
                    self.reviewItemSize = geometry.size.width - self.horizontalPadding * 2
                }
                return Color.clear
            }
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
                Text("4.7")
                    .font(70, .bold)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    HStack(spacing: 6) {
                        ForEach(0..<5) { _ in
                            Image(systemName: "star.fill")
                                .frame(width: 16, height: 16)
                        }
                    }
                    
                    Text("15만개의 평가")
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
                            .frame(width: reviewItemSize)
                            .shadow(color: Color.subGray, radius: 8, x: 2, y: 4)
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
            Text("원래 잘썼는데 업데이트하고나서")
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
                
                Text("2월 23일・dwronn")
                    .font(12)
                    .foregroundStyle(Color.subGray)
                
                Spacer()
            }
            .padding(.bottom, 8)
            
            
            
            Text("""
                ui 대대적 업데이트 후에 검색 결과 리스트뷰가 너무 보기 불편해졌어요
                1.한번검색하고나면 지도이동한 뒤에 이지역 재검색이 잘 안뜨고
                2. 장소별 마감시간을 보고싶은데 영업중이라고만 뜨고 몇시까지 인지는 안떠서 리스트에서 그 장소를 다 일일이 눌러서 들어가야 돼요(밤늦게 아직 마감시간이 많이남은 식당이나 카페 찾을떄!!!!)이것저것샬라샬라
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
    RatingAndReviewView()
}
