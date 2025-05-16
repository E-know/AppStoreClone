//
//  AppScreenShotView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/10/25.
//

import Kingfisher
import SwiftUI

struct AppScreenShotView: View {
    @State var imageWidth: CGFloat = 300
    let horizontalPadding: CGFloat = 21
    let imageUrls: [URL?]
    
    init(imageUrls: [URL?]) {
        self.imageUrls = imageUrls
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("미리 보기")
                    .font(19, .bold)
                Spacer()
            }
            .padding(.horizontal, 21)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [.init()]) {
                    ForEach(imageUrls, id: \.self) { url in
                        KFImage(url)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imageWidth)
                            .clipShape(RoundedRectangle(cornerRadius: 23))
                    }
                }
                .padding(.horizontal, horizontalPadding)
                .scrollTargetLayout()
            }
            .scrollIndicators(.never)
            .scrollTargetBehavior(.viewAligned)
            .overlay {
                GeometryReader() { geometry -> Color in
                    let totalWidth = geometry.size.width
                    let availableWidth = totalWidth - (self.horizontalPadding * 2)
                    Task { @MainActor in
                        self.imageWidth = availableWidth * (2 / 3)
                    }
                    return Color.clear
                }
            }
        }
    }
}
