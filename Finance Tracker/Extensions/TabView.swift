//
//  ContentView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 22.07.2024.
//

import SwiftUI

struct TabView: View {
    
    @State private var currentTab : String = "Expenses"
    
    var body: some View {
        
        TabView(selection: $currentTab){
            
            ExpensesView(currentTab: $currentTab).tag("Expenses").tabItem{
                Image(systemName: "creditcard.fill")
                Text("Expenses")
            }
            
            CategoriesView().tag("Categories").tabItem{
                Image(systemName: "list.clipboard.fill")
                Text("Categories")
            }
            
        }
    }
}

#Preview {
    TabView()
}
