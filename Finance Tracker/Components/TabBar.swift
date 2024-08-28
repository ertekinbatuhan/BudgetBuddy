//
//  ContentView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 22.07.2024.
//

import SwiftUI
import AppTrackingTransparency

struct TabBar: View {
    
    @State private var selectedTab: TabItem = .home
    @AppStorage("$ShowingOnBoarding") private var showingOnBoarding = true
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            FinanceView(currentTab: $selectedTab).tag(TabItem.home).tabItem {
                Image(systemName: TabItem.home.imageName)
                Text(TabItem.home.title)
                
            }
            
            SummaryView().tag(TabItem.summary).tabItem{
                Image(systemName: TabItem.summary.imageName)
                Text(TabItem.calendar.title)
            }
            
            CalendarView().tag(TabItem.calendar).tabItem{
                Image(systemName: TabItem.calendar.imageName)
                Text(TabItem.summary.title)
            }
            
            ReminderView().tag(TabItem.home).tabItem {
                Image(systemName: TabItem.reminders.imageName)
                Text(TabItem.reminders.title)
            }
            
            CategoriesView().tag(TabItem.categories).tabItem {
                Image(systemName: TabItem.categories.imageName)
                Text(TabItem.categories.title)

            }
        }
        .fullScreenCover(isPresented: $showingOnBoarding, content: {
            OnboardingView.init()
                .edgesIgnoringSafeArea(.all)
                .onDisappear{
                    showingOnBoarding = false
                    ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in })
                }
        })
    }
}

#Preview {
    TabBar()
}
