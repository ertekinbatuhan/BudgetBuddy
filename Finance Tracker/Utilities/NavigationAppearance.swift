//
//  NavigationAppearance.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 26.07.2024.
//

import SwiftUI

// MARK: - NavigationAppearance
struct NavigationAppearance {
    
    // MARK: - Configuration
    static func configure() {
        let appearance = UINavigationBarAppearance()
        
        // Configure the appearance for opaque background
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        
        // Set title text attributes
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        
        // Remove shadow
        appearance.shadowColor = nil
        
        // Apply the appearance settings to different navigation bar appearances
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
