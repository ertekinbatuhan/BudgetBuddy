//
//  TabItem.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 31.07.2024.
//

import Foundation

enum TabItem: String {
    case reminders = "Reminders"
    case home = "Home"
    case coins = "Coins"
    case categories = "Categories"
    
    var imageName: String {
        switch self {
        case .reminders:
            return "calendar.badge.plus"
        case .home:
            return "homekit"
        case .coins:
            return "bitcoinsign.circle"
        case .categories:
            return "list.clipboard.fill"
        }
    }
    
    var title: String {
        switch self {
        case .reminders:
            return "Reminders"
        case .home:
            return "Home"
        case .coins:
            return "Coins"
        case .categories:
            return "Categories"
        }
    }
}

