//
//  AppInfoDetailView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/5/25.
//

import Kingfisher
import SwiftUI


protocol AppInfoDetailStateProtocol {
    var infoViewModel: AppDetailInfoViewModel? { get }
    var showFullScreenshot: Bool { get }
    var fullScreenInitIndex: Int { get }
}

protocol AppInfoDetailIntentProtocol: AnyObject {
    func setShowFullScreenshot(_ showFullScreenshot: Bool)
    
    func requestAppInfo(_ request: AppInfoDetailModel.PresentAppInfo.Request)
    func requestDownload(_ request: AppInfoDetailModel.TabDownLoad.Request)
    func requestOpenApp(_ request: AppInfoDetailModel.OpenApp.Request)
    func requestStopDownload(_ request: AppInfoDetailModel.StopDownload.Request)
    func requestTapDeveloperButton(_ request: AppInfoDetailModel.TapDeveloperButton.Request)
    func requestFullScreenshot(_ request: AppInfoDetailModel.FullScreenshot.Request)
}

enum AppInfoDetailChildViewAction {
    case tapScreenShot(Int)
    case tapDeveloperButton
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
                        iconUrl: info.appIcon,
                        appName: info.appName,
                        appSubTitle: "",
                        downloadStatus: info.downloadStatus
                    )
                    .padding()
                    
                    AppInfoDetailMiddleView(
                        averageUserRating: info.averageUserRating,
                        averageUserRatingText: info.averageUserRatingText,
                        userRatingCountText: info.userRatingCountText,
                        contentAdvisoryRating: info.contentAdvisorRating,
                        gerne: info.genre,
                        developerName: info.developerName
                    )
                    .padding(.bottom, 11)
                    
                    AppInfoNewUpdatesView(
                        appVersion: info.appVersion,
                        releaseDate: info.releaseDateText,
                        releaseNote: info.releaseNotes
                    )
                    .padding(.bottom, 34)
                    
                    AppScreenShotView(imageUrls: info.screenshots) { action in
                        guard case let .tapScreenShot(index) = action else { return }
                        intent.requestFullScreenshot(.init(index: index))
                    }
                    .padding(.bottom, 20)
                    
                    AppIntroductView(description: info.appDescription, developerName: info.developerName) { action in
                        guard case .tapDeveloperButton = action else { return }
                        intent.requestTapDeveloperButton(.init())
                    }
                    .padding(.bottom, 25)
                    
                    RatingAndReviewView(
                        averageUserRating: info.averageUserRating,
                        averageUserRatingText: info.averageUserRatingText,
                        userRatingCountText: info.userRatingCountText
                    )
                    .padding(.bottom, 38)
                    
                    PrivacyInfoView(developerName: info.developerName)
                    
                    Spacer()
                }
            }
            .fullScreenCover(isPresented: bindingState(key: \.showFullScreenshot, setter: intent.setShowFullScreenshot)) {
                FullScreenshotView(
                    isPresented: bindingState(key: \.showFullScreenshot, setter: intent.setShowFullScreenshot),
                    imageUrls: state.infoViewModel?.screenshots,
                    initIndex: state.fullScreenInitIndex
                )
            }
            
        } else {
            ProgressView()
        }
        
    }
    
    private func TopInfoView(iconUrl: URL?, appName: String, appSubTitle: String, downloadStatus: DownloadStatus) -> some View {
        HStack(spacing: 16) {
            KFImage(iconUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 118, height: 118)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.subGray, lineWidth: 0.4)
                )
            
            VStack(alignment: .leading, spacing: 0) {
                Text(appName)
                    .font(19)
                    .padding(.bottom, 8)
                
                Text(appSubTitle)
                    .font(12)
                    .foregroundStyle(Color.subGray)
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    switch downloadStatus {
                        case .notInstalled:
                            Button(action: { intent.requestDownload(.init()) }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .frame(width: 75, height: 32)
                                        .foregroundStyle(Color.blue)
                                    
                                    Text("설치")
                                        .foregroundStyle(Color.white)
                                        .font(13, .bold)
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
                                        .font(13, .bold)
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
    
    private func bindingState<T>(key: KeyPath<AppInfoDetailStateProtocol, T>, setter: @escaping (T) -> Void) -> Binding<T> {
        Binding(get: {
            state[keyPath: key]
        }, set: setter)
    }
}

#Preview {
    let rawData = AppStoreSearchAPI.search(term: "Test").sampleData
    let entity = try? JSONDecoder().decode(AppStoreSearchEntity.self, from: rawData)
    let domain = entity?.toDomain()
    guard let appInfo = domain?.results.first else { return Text("Fail") }
    
    return NavigationStack {
        AppInfoDetailView(appInfo: appInfo)
    }
}
