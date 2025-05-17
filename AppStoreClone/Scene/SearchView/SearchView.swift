//
//  SearchView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/4/25.
//

import Kingfisher
import Combine
import SwiftUI

protocol SearchModelStateProtocol {
    var textTerm: String { get }
    var searchable: Bool { get }
    var appInfo: [AppStoreSearchResultViewModel]? { get }
    var goScrollTop: Bool { get }
    var navigationPath: [SearchNavigationPath] { get }
}

protocol SearchIntentProtocol {
    func setSearchBarTerm(_ term: String)
    func setSearchable(_ value: Bool)
    
    func searchApp(_ term: String)
    func setNavigationPath(_ path: [SearchNavigationPath])
    func appendNavigationPath(_ appID: Int)
}

struct SearchView: View {
    private let state: SearchModelStateProtocol
    private let intent: SearchIntentProtocol
    
    init() {
        let state = SearchState()
        self.state = state
        self.intent = SearchIntent(state: state)
    }
    
    
    var body: some View {
        NavigationStack(path: bindingState(key: \.navigationPath, setter: intent.setNavigationPath)) {
            Group {
                if let appInfo = state.appInfo {
                    if appInfo.isEmpty {
                        ContentUnavailableView {
                            Label("검색 실패", systemImage: "magnifyingglass")
                        } description: {
                            Text("검색한 결과가 없습니다. 다른 검색어로 검색해보세요.")
                                .lineSpacing(4)
                        }
                    } else {
                        ScrollViewReader { proxy in
                            ScrollView {
                                LazyVGrid(columns: [.init()], spacing: 0) {
                                    Color.clear
                                        .frame(height: 0)
                                        .id("top")
                                    
                                    ForEach(appInfo) { info in
                                        Button(action: {
                                            intent.appendNavigationPath(info.appId)
                                        }) {
                                            AppInfoCellView(appInfo: info)
                                                .padding(.vertical, 24)
                                        }
                                        
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                            .onChange(of: state.goScrollTop) {
                                withAnimation {
                                    proxy.scrollTo("top", anchor: .top)
                                }
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("검색")
            .toolbarTitleDisplayMode(.inlineLarge)
            .searchable(
                text: bindingState(key: \.textTerm, setter: intent.setSearchBarTerm),
                isPresented: bindingState(key: \.searchable, setter: intent.setSearchable),
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "게임, 앱, 스토리 등"
            )
            .onSubmit(of: .search) {
                intent.searchApp(state.textTerm)
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
    
    private func bindingState<T>(key: KeyPath<SearchModelStateProtocol, T>, setter: @escaping (T) -> Void) -> Binding<T> {
        Binding(get: { state[keyPath: key] }, set: setter)
    }
}

#Preview {
    SearchView()
}
