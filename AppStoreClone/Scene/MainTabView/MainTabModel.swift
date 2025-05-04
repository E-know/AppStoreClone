//
//  MainTabModel.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/4/25.
//

import SwiftUI

enum MainTabModel {
    enum Tabs: String, CaseIterable, Identifiable {
        case today = "투데이"
        case games = "게임"
        case apps = "앱"
        case arcade = "Arcade"
        case search = "검색"
        
        var id: String {
            self.rawValue
        }
        
        var tabImageName: String {
            switch self {
                case .today:
                    return "text.rectangle.page"
                case .games:
                    return "gamecontroller"
                case .apps:
                    return "square.stack.3d.up"
                case .arcade:
                    return "arcade.stick"
                case .search:
                    return "magnifyingglass"
            }
        }
        
        @ViewBuilder
        var tabView: some View {
            switch self {
                case .today:
                    Text("Today")
                case .games:
                    Text("Games")
                case .apps:
                    Text("Apps")
                case .arcade:
                    Text("Arcade")
                case .search:
                    SearchView()
            }
        }
    } // Tabs End
}
