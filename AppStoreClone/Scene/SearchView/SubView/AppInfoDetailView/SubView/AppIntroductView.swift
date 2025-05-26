//
//  AppIntroductView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/10/25.
//

import SwiftUI

struct AppIntroductView: View {
    @State var descriptionMultiLineCount: Int? = 3
    private let textFontSize: CGFloat = 12
    
    private let description: String
    private let developerName: String
    weak var intent: AppInfoDetailIntentProtocol?
    private let action: (AppInfoDetailChildViewAction) -> Void
    
    init(description: String, developerName: String, action: @escaping (AppInfoDetailChildViewAction) -> Void) {
        self.description = description
        self.developerName = developerName
        self.action = action
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(description)
                        .font(textFontSize)
                        .lineSpacing(textFontSize * 0.7)
                        .lineLimit(descriptionMultiLineCount)
                }
                
                Spacer()
                
                if descriptionMultiLineCount != nil {
                    VStack {
                        Spacer()
                        
                        Button(action: {
                            descriptionMultiLineCount = nil
                        }) {
                            Text("더 보기")
                                .font(textFontSize)
                        }
                    }
                }
            }
            
            Button(action: {
                action(.tapDeveloperButton)
            }) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(developerName)
                            .font(textFontSize)
                            .padding(.bottom, 2)
                        
                        Text("개발자")
                            .foregroundStyle(Color.subGray)
                            .font(textFontSize)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 15)
                        .foregroundStyle(Color.subGray)
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
    guard let viewModel = domain?.results.first?.toDetailViewModel() else { return Text("Error") }
    
    return AppIntroductView(description: viewModel.appDescription, developerName: viewModel.developerName, action: { _ in })
}
