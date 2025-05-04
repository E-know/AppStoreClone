//
//  SearchView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/4/25.
//

import SwiftUI

struct SearchView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomNavigationBar()
                    .padding()
                
                ScrollView {
                    VStack {
                        Text("Hello World")
                    }
                }
            }
        }
    }
    
    private func CustomNavigationBar() -> some View {
        HStack {
            Text("검색")
                .font(.system(size: 34, weight: .black))
            Spacer()
            Button(action: {
                print("Tapped")
            }) {
                Image(systemName: "gear")
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SearchView()
}
