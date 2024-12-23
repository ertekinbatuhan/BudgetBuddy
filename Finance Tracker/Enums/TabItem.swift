//
//  TabItem.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 31.07.2024.
//

import Foundation

enum TabItem: String {
    case reminders = "TAB_REMINDERS"
    case home = "TAB_HOME"
    case coins = "TAB_COINS"
    case categories = "TAB_CATEGORIES"
    case summary = "TAB_OVERVIEW"
    
    var imageName: String {
        switch self {
        case .reminders:
            return FinanceIcons.reminderIcon
        case .home:
            return FinanceIcons.homeIcon
        case .summary:
            return FinanceIcons.summaryIcon
        case .coins:
            return FinanceIcons.coinsIcon
        case .categories:
            return FinanceIcons.categoriesIcon
        }
    }
    
    var title: String {
        switch self {
        case .reminders:
            return NSLocalizedString("TAB_REMINDERS_TITLE", comment: "")
        case .home:
            return NSLocalizedString("TAB_HOME_TITLE", comment: "")
        case .summary:
            return NSLocalizedString("TAB_SUMMARY_TITLE", comment: "")
        case .coins:
            return NSLocalizedString("TAB_COINS_TITLE", comment: "")
        case .categories:
            return NSLocalizedString("TAB_CATEGORIES_TITLE", comment: "")
        }
    }
}
