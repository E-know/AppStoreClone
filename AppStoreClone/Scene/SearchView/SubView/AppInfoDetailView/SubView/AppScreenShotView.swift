//
//  AppScreenShotView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/10/25.
//

import Kingfisher
import SwiftUI

struct AppScreenShotView: View {
    private let screenshotSpacing: CGFloat = 10
    private let horizontalPadding: CGFloat = 21
    let imageUrls: [URL?]
    private let action: (AppInfoDetailChildViewAction) -> Void
    
    init(imageUrls: [URL?], action: @escaping (AppInfoDetailChildViewAction) -> Void) {
        self.imageUrls = imageUrls
        self.action = action
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
                LazyHGrid(rows: [.init()], spacing: screenshotSpacing) {
                    ForEach(imageUrls.indices, id: \.self) { index in
                        Button(action: {
                            action(.tapScreenShot(index))
                        } ) {
                            KFImage(imageUrls[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .containerRelativeFrame(.horizontal) { length, _ in
                                    let width = (length - horizontalPadding * 2 - screenshotSpacing) * 2 / 3
                                    return width > 0 ? width : 0
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 23))
                        }
                    }
                }
                .padding(.horizontal, horizontalPadding)
                .scrollTargetLayout()
            }
            .scrollIndicators(.never)
            .scrollTargetBehavior(.viewAligned)
        }
    }
}
