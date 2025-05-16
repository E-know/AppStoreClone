//
//  SearchView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/4/25.
//

import Kingfisher
import Combine
import SwiftUI

struct SearchView: View {
    @State var state: SearchModelStateProtocol
    private let intent: SearchIntentProtocol
    
    init() {
        let state = SearchState()
        self.state = state
        self.intent = SearchIntent(state: state)
    }

    
    var body: some View {
        NavigationStack(path: bindingState(key: \.navigationPath, setter: intent.setNavigationPath)) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVGrid(columns: [.init()], spacing: 0) {
                        Color.clear
                            .frame(height: 0)
                            .id("top")

                        ForEach(state.appInfo) { info in
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
                .onChange(of: state.goScrollTop) {
                    withAnimation {
                        proxy.scrollTo("top", anchor: .top)
                    }
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
    }
    
    private func bindingState<T>(key: KeyPath<SearchModelStateProtocol, T>, setter: @escaping (T) -> Void) -> Binding<T> {
        Binding(get: {
            state[keyPath: key]
        }, set: setter)
    }
}

#Preview {
    SearchView()
}
