//
//  SearchView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/4/25.
//

import Combine
import SwiftUI

struct SearchView: View {
    @State var state: SearchModelStateProtocol
    private var intent: SearchIntentProtocol
    
    init() {
        let state = SearchState()
        self.state = state
        self.intent = SearchIntent(state: state)
    }

    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [.init()], spacing: 0) {
                    ForEach(state.appInfo) { info in
                        NavigationLink(value: info) {
                            AppInfoCellView(appInfo: info)
                                .padding(.vertical, 24)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("검색")
            .toolbarTitleDisplayMode(.inlineLarge)
            .searchable(text: bindingTerm(), isPresented: bindingSearchable(), placement: .navigationBarDrawer(displayMode: .always), prompt: "게임, 앱, 스토리 등")
            .onSubmit(of: .search) {
                intent.searchApp(state.textTerm)
            }
            .navigationDestination(for: AppStoreSearchResultViewModel.self) { _ in
                AppInfoDetailView()
            }
        }
    }
    
    // FIXME: 뭔가 binding 함수들은 generic으로 묶을 수 있을것 같은데 못 묶겠다..
//    private func binding<T>(for keypath: KeyPath<SearchModelStateProtocol, T>) -> Binding<T> {
//        Binding(
//            get: {
//                state[keyPath: keypath]
//            },
//            set: { newValue in
//                intent.setSearchBarTerm(newValue)
//            }
//        )
//    }
    
    private func bindingTerm() -> Binding<String> {
        Binding(
            get: {
                state.textTerm
            },
            set: { newValue in
                intent.setSearchBarTerm(newValue)
            }
        )
    }
    
    private func bindingSearchable() -> Binding<Bool> {
        Binding(
            get: {
                state.searchable
            },
            set: { newValue in
                intent.setSearchable(newValue)
            })
    }
}

#Preview {
    SearchView()
}
