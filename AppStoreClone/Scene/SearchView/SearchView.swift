//
//  SearchView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/4/25.
//

import Combine
import Kingfisher
import SwiftUI

protocol SearchModelStateProtocol {
    var textTerm: String { get }
    var searchable: Bool { get }
    var appInfo: [AppStoreSearchResultViewModel]? { get }
    var goScrollTop: Bool { get }
    var navigationPath: [SearchNavigationPath] { get }
}

protocol SearchIntentProtocol: AnyObject {
    func setSearchBarTerm(_ term: String)
    func setSearchable(_ value: Bool)
    func setNavigationPath(_ path: [SearchNavigationPath])
    
    func requestSearchApp(_ request: SearchModel.SearchApp.Request)
    func requestGoNavigation(_ request: SearchModel.GoNavigation.Request)
    
    func requestDownloadApp(_ request: SearchModel.DownloadApp.Request)
    func requestStopDownloadApp(_ request: SearchModel.StopDownloadApp.Request)
    func requestOpenApp(_ request: SearchModel.OpenApp.Request)
}

struct SearchView: MVIView {
    let state: SearchModelStateProtocol
    private let intent: SearchIntentProtocol
    
    init() {
        let state = SearchState()
        self.state = state
        self.intent = SearchIntent(state: state)
    }
    
    
    var body: some View {
        NavigationStack(path: bind(\.navigationPath, intent.setNavigationPath)) {
            Group {
                if let appInfo = state.appInfo {
                    if appInfo.isEmpty {
                        SearchFailView
                    } else {
                        SearchAppResultView(appInfo: appInfo)
                    }
                } else {
                    Text("검색")
                }
            }
            .navigationTitle("검색")
            .toolbarTitleDisplayMode(.inlineLarge)
            .searchable(
                text: bind(\.textTerm, intent.setSearchBarTerm),
                isPresented: bind(\.searchable, intent.setSearchable),
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "게임, 앱, 스토리 등"
            )
            .onSubmit(of: .search) {
                intent.requestSearchApp(.init(term: state.textTerm))
            }
            .navigationDestination(for: SearchNavigationPath.self) { path in
                if case let .appDetail(data) = path {
                    AppInfoDetailView(appInfo: data)
                } else {
                    Text("Error")
                }
            }
        }
    }
    
    private var SearchFailView: some View {
        ContentUnavailableView {
            Label("검색 실패", systemImage: "magnifyingglass")
        } description: {
            Text("검색한 결과가 없습니다. 다른 검색어로 검색해보세요.")
                .lineSpacing(4)
        }
    }
    
    private func SearchAppResultView(appInfo: [AppStoreSearchResultViewModel]) -> some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVGrid(columns: [.init()], spacing: 0) {
                    ForEach(appInfo) { info in
                        Button(action: {
                            intent.requestGoNavigation(.init(appID: info.appId))
                        }) {
                            AppInfoCellView(appInfo: info, intent: intent)
                                .padding(.vertical, 24)
                        }
                    }
                }
                .id("top")
                .padding(.horizontal, 20)
            }
            .onChange(of: state.goScrollTop) {
                withAnimation {
                    proxy.scrollTo("top", anchor: .top)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
