//
//  AppInfoNewUpdatesView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/5/25.
//

import SwiftUI

struct AppInfoNewUpdatesView: View {
    @State var releaseNoteMultiLine: Int? = 2
    private let appVersion: String
    private let releaseDate: String
    private let releaseNote: String
    
    
    init(appVersion: String, releaseDate: String, releaseNote: String) {
        self.appVersion = appVersion
        self.releaseDate = releaseDate
        self.releaseNote = releaseNote
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: { print("새로운 소식")}) {
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
                Text("버전 \(appVersion)")
                    .font(12)
                
                Spacer()
                
                Text(releaseDate)
                    .font(12)
            }
            .foregroundStyle(Color.subGray)
            .padding(.bottom, 14)
            
            HStack {
                Text(releaseNote)
                    .font(12)
                    .lineSpacing(8)
                    .lineLimit(releaseNoteMultiLine)
                
                Spacer()
                
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

#Preview {
    let rawData = AppStoreSearchAPI.search(term: "Test").sampleData
    let entity = try? JSONDecoder().decode(AppStoreSearchEntity.self, from: rawData)
    let domain = entity?.toDomain()
    guard let viewModel = domain?.results.first?.toDetailViewModel() else {
        return Text("Error")
    }
    return AppInfoNewUpdatesView(appVersion: viewModel.appVersion, releaseDate: viewModel.releaseDateText, releaseNote: viewModel.releaseNotes)
}
