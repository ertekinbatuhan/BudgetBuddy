//
//  FinanceViewModel.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 24.07.2024.
//

import SwiftUI
import SwiftData

class FinanceViewModel: ObservableObject {
    
    @Published var groupedExpenses: [GroupedFinances] = []
    @Published var originalGroupedExpenses: [GroupedFinances] = []
    @Published var searchText: String = ""
    @Published var addFinance: Bool = false
    @Published var selectedType: FinanceType = .expense
    var allExpenses: [Finance] = []
    var allCategories: [Category] = []
    
    var expenseCategories: [Category] {
        allCategories.filter { category in
            allExpenses.contains { $0.financeType == .expense && $0.category == category }
        }
    }
    
    var incomeCategories: [Category] {
        allCategories.filter { category in
            allExpenses.contains { $0.financeType == .income && $0.category == category }
        }
    }
    
    var expenseCategoryColors: [Category: Color] {
        Dictionary(uniqueKeysWithValues: expenseCategories.map { ($0, .randomColor()) })
    }
    
    var incomeCategoryColors: [Category: Color] {
        Dictionary(uniqueKeysWithValues: incomeCategories.map { ($0, .randomColor()) })
    }
    
    var categoryColors: [Category: Color] {
        switch selectedType {
        case .expense:
            return expenseCategoryColors
        case .income:
            return incomeCategoryColors
        }
    }
    
    var totalExpenseAmountString: String {
        NumberFormatter.currencyFormatter.string(for: totalAmount(for: .expense)) ?? ""
    }
    
    var totalIncomingAmountString: String {
        NumberFormatter.currencyFormatter.string(for: totalAmount(for: .income)) ?? ""
    }
    
    func totalAmount(for type: FinanceType) -> Double {
        return allExpenses.filter { $0.financeType == type }.reduce(0) { $0 + $1.amount }
    }
    
    func filterExpenses(_ text: String) {
        let query = text.lowercased()
        
        let filteredGroups = self.originalGroupedExpenses
            .compactMap { group -> GroupedFinances? in
                let filteredExpenses = group.finances.filter {
                    $0.title.lowercased().contains(query) && $0.financeType == self.selectedType
                }
                return filteredExpenses.isEmpty ? nil : GroupedFinances(date: group.date, finances: filteredExpenses)
            }
        
        self.groupedExpenses = filteredGroups
    }
    
    func filterExpensesByType(_ type: FinanceType) {
        let filteredGroups = self.originalGroupedExpenses
            .compactMap { group -> GroupedFinances? in
                let filteredExpenses = group.finances.filter { $0.financeType == type }
                return filteredExpenses.isEmpty ? nil : GroupedFinances(date: group.date, finances: filteredExpenses)
            }
        
        self.groupedExpenses = filteredGroups
    }
    
    func resetFilters() {
        if searchText.isEmpty {
            filterExpensesByType(selectedType)
        } else {
            filterExpenses(searchText)
        }
    }

    func deleteExpense(_ expense: Finance, from group: GroupedFinances, context: ModelContext) {
        context.delete(expense)
        withAnimation {
            if let groupIndex = groupedExpenses.firstIndex(where: { $0.id == group.id }) {
                if let expenseIndex = groupedExpenses[groupIndex].finances.firstIndex(where: { $0.id == expense.id }) {
                    groupedExpenses[groupIndex].finances.remove(at: expenseIndex)
                }
                
                if groupedExpenses[groupIndex].finances.isEmpty {
                    groupedExpenses.remove(at: groupIndex)
                }
            }
        }
    }
    
    func createGroupedExpenses(_ expenses: [Finance]) {
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
                self.originalGroupedExpenses = sortedDict.compactMap { dict in
                    let date = Calendar.current.date(from: dict.key) ?? .init()
                    return GroupedFinances(date: date, finances: dict.value)
                }
                self.resetFilters()
            }
        }
    }
}
    