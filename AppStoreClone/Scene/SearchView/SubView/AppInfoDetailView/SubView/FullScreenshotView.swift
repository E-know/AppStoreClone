//
//  FullScreenshotView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/18/25.
//

import Kingfisher
import SwiftUI

struct FullScreenshotView: View {
    @Binding var isPresented: Bool
    private let imageUrls: [URL?]?
    private let horizontalPadding: CGFloat = 20
    private let initIndex: Int
    
    init(isPresented: Binding<Bool>, imageUrls: [URL?]?, initIndex: Int) {
        self._isPresented = isPresented
        self.imageUrls = imageUrls
        self.initIndex = initIndex
    }
    
    
    var body: some View {
        VStack(alignment: .trailing) {
            Button(action: { isPresented.toggle() }) {
                Text("확인")
            }
            .padding(.horizontal, horizontalPadding)
            
            if let urls = imageUrls?.compactMap({ $0 }) {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [.init()]) {
                            ForEach(urls.indices, id: \.self) { index in
                                KFImage(urls[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 23))
                                    .containerRelativeFrame(.horizontal) { length, _ in
                                        let width = (length - horizontalPadding * 2)
                                        return width > 0 ? width : 0
                                    }
                                    .id(index)
                            }
                        }
                        .padding(.horizontal, horizontalPadding)
                        .scrollTargetLayout()
                    }
                    .scrollIndicators(.never)
                    .scrollTargetBehavior(.viewAligned)
                    .frame(maxHeight: .infinity)
                    .onAppear {
                        proxy.scrollTo(initIndex, anchor: .leading)
                    }
                }
            }
        }
    }
}

//#Preview {
//    let urlStrings = [
//        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/ed/23/4f/ed234f0e-ff53-b73b-a60b-9edf2d772afe/iOS_5.5_01.jpg/392x696bb.jpg",
//        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/3d/cf/52/3dcf52a0-604d-24d7-b5b2-5f820db5ad0a/iOS_5.5_02.jpg/392x696bb.jpg",
//        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/bd/e9/fc/bde9fcd9-f6e0-cca6-c876-4f0f6be22229/iOS_5.5_03.jpg/392x696bb.jpg",
//        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/43/66/d8/4366d87e-3207-9555-5609-2c87b015c739/iOS_5.5_04.jpg/392x696bb.jpg",
//        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/3a/71/58/3a7158fc-42f5-d2af-35a3-25d76e67a244/iOS_5.5_05.jpg/392x696bb.jpg",
//        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/27/b6/17/27b61713-7075-3fd0-318d-8bc35b530917/iOS_5.5_06.jpg/392x696bb.jpg",
//        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/ba/02/71/ba02715a-c3d5-b062-8ec6-9c2c227c497f/iOS_5.5_07.jpg/392x696bb.jpg",
//        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/18/8d/23/188d2351-be90-918a-17ae-4bedfd233828/iOS_5.5_08.jpg/392x696bb.jpg"
//      ]
//    
//    let urls = urlStrings.map { URL(string: $0) }
//
//    FullScreenshotView(isPresented: true, imageUrls: urls)
//}
