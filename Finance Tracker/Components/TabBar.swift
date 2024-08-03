//
//  ContentView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 22.07.2024.
//

import SwiftUI

struct TabBar: View {
    
    @State private var selectedTab: TabItem = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FinanceView(currentTab: $selectedTab).tag(TabItem.home).tabItem {
                Image(systemName: TabItem.home.imageName)
                Text(TabItem.home.title)
            }
            CoinsView().tag(TabItem.coins).tabItem {
                Image(systemName: TabItem.coins.imageName)
                Text(TabItem.coins.title)
            }
            CategoriesView().tag(TabItem.categories).tabItem {
                Image(systemName: TabItem.categories.imageName)
                Text(TabItem.categories.title)
            }
        }
    }
}

#Preview {
    TabBar()
}
