//
//  MainTabView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/4/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selected = MainTabModel.Tabs.search
    var body: some View {
        TabView(selection: $selected) {
            ForEach(MainTabModel.Tabs.allCases, id: \.self) { tabInfo in
                if tabInfo == .search {
                    Tab(tabInfo.rawValue, systemImage: tabInfo.tabImageName, value: tabInfo, role: .search) {
                        tabInfo.tabView
                    }
                } else {
                    Tab(tabInfo.rawValue, systemImage: tabInfo.tabImageName, value: tabInfo) {
                        tabInfo.tabView
                    }
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
