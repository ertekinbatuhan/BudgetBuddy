//
//  ExpenseType.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 2.08.2024.
//

import Foundation

enum FinanceType: String, CaseIterable, Identifiable {
    case expense = "Expense"
    case income = "Income"
    
    var id: String { self.rawValue }
}
