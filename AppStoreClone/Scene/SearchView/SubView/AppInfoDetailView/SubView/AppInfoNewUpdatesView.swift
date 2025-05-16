//
//  AppInfoNewUpdatesView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/5/25.
//

import SwiftUI

struct AppInfoNewUpdatesView: View {
    @State var releaseNoteMultiLine: Int? = 2
    private let releaseNote: String
    
    init(releaseNote: String) {
        self.releaseNote = releaseNote
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {print("새로운 소식")}) {
                HStack {
                    Text("새로운 소식")
                        .font(19, .bold)
                        .foregroundStyle(Color.black)
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.subGray)
                    
                    Spacer()
                }
            }
            .padding(.bottom, 12)
            
            HStack {
                Text("버전 2.47.1")
                    .font(12)
                
                Spacer()
                
                Text("2주 전")
                    .font(12)
            }
            .foregroundStyle(Color.subGray)
            .padding(.bottom, 14)
            
            HStack {
                Text(releaseNote)
                .font(12)
                .lineSpacing(8)
                .lineLimit(releaseNoteMultiLine)
                
                // TODO: 이 부분 수정하기.
                if releaseNoteMultiLine != nil {
                    VStack {
                        Spacer()
                        Button(action: { releaseNoteMultiLine = nil }) {
                            Text("더 보기")
                                .font(12)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
