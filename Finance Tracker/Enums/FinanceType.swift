//
//  ExpenseType.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 2.08.2024.
//

import Foundation

enum FinanceType: String, CaseIterable, Identifiable {
    case expense = "EXPENSE"
    case income = "INCOME"
    
    var id: String { self.rawValue }
    
    var localizedTitle: String {
        switch self {
        case .expense:
            return NSLocalizedString("FINANCE_TYPE_EXPENSE", comment: "Expense")
        case .income:
            return NSLocalizedString("FINANCE_TYPE_INCOME", comment: "Income")
        }
    }
}
