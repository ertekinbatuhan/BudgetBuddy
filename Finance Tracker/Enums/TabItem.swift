//
//  TabItem.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 31.07.2024.
//

import Foundation

enum TabItem: String {
    case expenses = "Expenses"
    case coins = "Coins"
    case categories = "Categories"
    
    var imageName: String {
        switch self {
        case .expenses:
            return "creditcard.fill"
        case .coins:
            return "bitcoinsign.circle"
        case .categories:
            return "list.clipboard.fill"
        }
    }
    
    var title: String {
        switch self {
        case .expenses:
            return "Expenses"
        case .coins:
            return "Coins"
        case .categories:
            return "Categories"
        }
    }
}

