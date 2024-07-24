//
//  ExpenseViewModel.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 24.07.2024.
//

import Foundation
import SwiftUI
import SwiftData

class ExpensesViewModel: ObservableObject {
    
    @Published var groupedExpenses: [GroupedExpenses] = []
    @Published var originalGroupedExpenses: [GroupedExpenses] = []
    @Published var searchText: String = ""
    @Published var addExpense: Bool = false
    var allExpenses: [Expense] = []
    var allCategories: [Category] = []
    
    var categoryColors: [Category: Color] {
        Dictionary(uniqueKeysWithValues: allCategories.map { ($0, .randomColor()) })
    }
    
    var totalAmountString: String {
        NumberFormatter.currencyFormatter.string(for: totalAmount) ?? ""
    }
    
    private var totalAmount: Double {
        allExpenses.reduce(0) { $0 + $1.amount }
    }
    
    func filterExpenses(_ text: String) {
        Task.detached(priority: .high) {
            let query = text.lowercased()
            let filteredGroups = self.originalGroupedExpenses.compactMap { group -> GroupedExpenses? in
                let filteredExpenses = group.expenses.filter { $0.title.lowercased().contains(query) }
                return filteredExpenses.isEmpty ? nil : GroupedExpenses(date: group.date, expenses: filteredExpenses)
            }
            
            await MainActor.run {
                self.groupedExpenses = filteredGroups
            }
        }
    }
    
    func deleteExpense(_ expense: Expense, from group: GroupedExpenses, context: ModelContext) {
        context.delete(expense)
        withAnimation {
            if let groupIndex = groupedExpenses.firstIndex(where: { $0.id == group.id }) {
                if let expenseIndex = groupedExpenses[groupIndex].expenses.firstIndex(where: { $0.id == expense.id }) {
                    groupedExpenses[groupIndex].expenses.remove(at: expenseIndex)
                }
                
                if groupedExpenses[groupIndex].expenses.isEmpty {
                    groupedExpenses.remove(at: groupIndex)
                }
            }
        }
    }
    
    func createGroupedExpenses(_ expenses: [Expense]) {
        Task.detached(priority: .high) {
            let groupedDict = Dictionary(grouping: expenses) { expense in
                let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: expense.date)
                return dateComponents
            }
            
            let sortedDict = groupedDict.sorted {
                let calendar = Calendar.current
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()
                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            
            await MainActor.run {
                self.groupedExpenses = sortedDict.compactMap { dict in
                    let date = Calendar.current.date(from: dict.key) ?? .init()
                    return GroupedExpenses(date: date, expenses: dict.value)
                }
                self.originalGroupedExpenses = self.groupedExpenses
            }
        }
    }
}
