//
//  MainTabView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/4/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ForEach(MainTabModel.Tabs.allCases) { tabInfo in
                Tab(tabInfo.rawValue, systemImage: tabInfo.tabImageName) {
                    tabInfo.tabView
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
