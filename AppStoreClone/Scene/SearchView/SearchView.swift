//
//  SearchView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/4/25.
//

import SwiftUI

struct SearchView: View {
    @State var textTerm: String = ""
    @State var presentSearchable = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 48) {
                    ForEach(0..<10, id: \.self) { num in
                        NavigationLink(value: num) {
                            AppInfoCellView()
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("검색")
            .toolbarTitleDisplayMode(.inlineLarge)
            .searchable(text: $textTerm,isPresented: $presentSearchable ,placement: .navigationBarDrawer(displayMode: .always), prompt: "게임, 앱, 스토리 등..")
            .onSubmit(of: .search) {
                print("Submit")
            }
            .navigationDestination(for: Int.self) { _ in
                AppInfoDetailView()
            }
        }
    }
}

#Preview {
    SearchView()
}
