//
//  ContentView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 22.07.2024.
//

import SwiftUI

struct TabBar: View {
    
    @State private var selectedTab: TabItem = .expenses
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ExpensesView(currentTab: $selectedTab).tag(TabItem.expenses).tabItem {
                Image(systemName: TabItem.expenses.imageName)
                Text(TabItem.expenses.title)
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
