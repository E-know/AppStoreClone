//
//  AppInfoDetailView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/5/25.
//

import Kingfisher
import SwiftUI


protocol AppInfoDetailStateProtocol {
    var infoViewModel: AppStoreSearchResultViewModel? { get }
    var downloadStatus: DownloadStatus { get }
}

protocol AppInfoDetailIntentProtocol {
    func requestAppInfo(_ request: AppInfoDetailModel.PresentAppInfo.Request)
    func requestDownload(_ request: AppInfoDetailModel.TabDownLoad.Request)
    func requestOpenApp(_ request: AppInfoDetailModel.OpenApp.Request)
    func requestStopDownload(_ request: AppInfoDetailModel.StopDownload.Request)
}

struct AppInfoDetailView: View {
    private let state: AppInfoDetailStateProtocol
    private let intent: AppInfoDetailIntentProtocol
    
    init(appInfo: AppStoreSearchResultDomain) {
        let state = AppInfoDetailState()
        self.intent = AppInfoDetailIntent(state)
        self.state = state
        
        intent.requestAppInfo(.init(appInfo: appInfo))
    }
    
    var body: some View {
        if let info = state.infoViewModel {
            ScrollView {
                VStack {
                    TopInfoView(
                        iconUrl: info.appIcon512,
                        appName: info.appName,
                        appSubTitle: ""
                    )
                    .padding()
                    
                    AppInfoDetailMiddleView()
                        .padding(.bottom, 11)
                    
                    AppInfoNewUpdatesView(releaseNote: info.releaseNotes)
                        .padding(.bottom, 34)
                    
                    AppScreenShotView(imageUrls: info.screenshotUrls)
                        .padding(.bottom, 20)
                    
                    AppIntroductView(
                        description: info.description,
                        developerName: info.developerName
                    )
                    .padding(.bottom, 25)
                    
                    RatingAndReviewView()
                        .padding(.bottom, 38)
                    
                    PrivacyInfoView()
                    
                    Spacer()
                }
            }
        } else {
            ProgressView()
        }
    }
    
    private func TopInfoView(iconUrl: URL?, appName: String, appSubTitle: String) -> some View {
        HStack(spacing: 16) {
            KFImage(iconUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 118, height: 118)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading, spacing: 0) {
                Text(appName)
                    .font(.system(size: 19))
                    .padding(.bottom, 8)
                
                Text(appSubTitle)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.subGray)
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    switch state.downloadStatus {
                        case .notInstalled:
                            Button(action: { intent.requestDownload(.init()) }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .frame(width: 75, height: 32)
                                        .foregroundStyle(Color.blue)
                                    
                                    Text("설치")
                                        .foregroundStyle(Color.white)
                                        .font(.system(size: 13, weight: .bold))
                                }
                            }
                        case .downloading(let percent):
                            Button(action: { intent.requestStopDownload(.init()) } ) {
                                CircularProgressView(progress: percent)
                            }
                        case .installed:
                            Button(action: { intent.requestOpenApp(.init()) }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .frame(width: 75, height: 32)
                                        .foregroundStyle(Color.blue)
                                    
                                    Text("열기")
                                        .foregroundStyle(Color.white)
                                        .font(.system(size: 13, weight: .bold))
                                }
                            }
                    }
                    
                    Spacer()
                    
                    if let appStoreURL = state.infoViewModel?.appStoreURL {
                        ShareLink(item: appStoreURL, label: {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundStyle(Color.blue)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18)
                                .padding(.bottom, 2)
                        })
                    }
                }
            }
        }
    }
}

//#Preview {
//    NavigationStack {
//        AppInfoDetailView()
//    }
//}
