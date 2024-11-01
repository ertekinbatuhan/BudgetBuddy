//
//  LocalizedStrings.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 1.11.2024.
//

import SwiftUI
// MARK: - LocalizedStrings
enum LocalizedStrings {
    case generalTotal
    case financeTypeIncome
    case financeTypeExpense
    
    var text: String {
        switch self {
        case .generalTotal:
            return NSLocalizedString("GENERAL_TOTAL", comment: "Total amount")
        case .financeTypeIncome:
            return NSLocalizedString("FINANCE_TYPE_INCOME", comment: "Income")
        case .financeTypeExpense:
            return NSLocalizedString("FINANCE_TYPE_EXPENSE", comment: "Expense")
        }
    }
}
