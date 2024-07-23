//
//  Finance_TrackerApp.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 22.07.2024.
//

import SwiftUI
import SwiftData

@main
struct Finance_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        .modelContainer(for : [Expense.self, Category.self])
    }
}
