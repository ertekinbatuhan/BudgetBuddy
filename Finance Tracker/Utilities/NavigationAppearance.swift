//
//  NavigationAppearance.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 26.07.2024.
//

import Foundation
import SwiftUI

struct NavigationAppearance {
    static func configure() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        appearance.shadowColor = nil

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}