//
//  RatingStarView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/12/25.
//

import SwiftUI

struct RatingStarView: View {
    private let starSize: CGFloat
    private let spacing: CGFloat
    private let rating: Double
    private let rectangleWidth: CGFloat
    private let color: Color
    
    init(starSize: CGFloat = 30, spacing: CGFloat = 6, rating: Double = 2.5, color: Color = .black) { // Rating 20% 단위로 잘라야 할듯.
        self.starSize = starSize
        self.spacing = spacing
        self.rating = rating
        self.color = color
        
        let filledStarCount = CGFloat(Int(rating))
        rectangleWidth = starSize * filledStarCount + spacing * filledStarCount + (rating - filledStarCount) * starSize
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack(spacing: spacing) {
                ForEach(0..<5) { _ in
                    Image(systemName: "star")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: starSize, height: starSize)
                }
            }
            .foregroundStyle(Color.subGray)
            
            Rectangle()
                .frame(width: rectangleWidth, height: starSize)
                .mask(alignment: .leading) {
                    HStack(spacing: spacing) {
                        ForEach(0..<5) { _ in
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: starSize, height: starSize)
                        }
                    }
                }
                .foregroundStyle(color)
            
            
        }
    }
}

#Preview {
    RatingStarView()
}
