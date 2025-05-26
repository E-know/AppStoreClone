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

#Preview {
    let rawData = AppStoreSearchAPI.search(term: "EXAM").sampleData
    let entity = try? JSONDecoder().decode(AppStoreSearchEntity.self, from: rawData)
    let domain = entity?.toDomain()
    guard let screenshots = domain?.results.first?.toDetailViewModel().screenshots else {
        return Text("Error")
    }
    return FullScreenshotView(isPresented: .constant(true), imageUrls: screenshots, initIndex: 0)
}
