//
//  Finance_TrackerApp.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 22.07.2024.
//

import SwiftUI
import SwiftData
import GoogleMobileAds

@main
struct Finance_TrackerApp: App {
    
    init() {
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    var body: some Scene {
        WindowGroup {
            TabBar()
            
        }
        .modelContainer(for: [Finance.self, Reminder.self , Category.self])
    }
}
