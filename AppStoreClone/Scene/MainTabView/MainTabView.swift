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
            ForEach(MainTabModel.Tabs.allCases) { tabInfo in
                Tab(tabInfo.rawValue, systemImage: tabInfo.tabImageName, value: tabInfo, content: {
                    tabInfo.tabView
                })
            }
        }
    }
}

#Preview {
    MainTabView()
}
