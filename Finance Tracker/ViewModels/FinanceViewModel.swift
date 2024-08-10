//
//  FinanceViewModel.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 24.07.2024.
//

import SwiftUI
import SwiftData

protocol FinanceViewModelProtocol {
    func totalAmount(for type: FinanceType) -> Double
    func filterFinances(_ text: String)
    func filterFinancesByType(_ type: FinanceType)
    func resetFilters()
    func deleteFinance(_ finances: Finance, from group: GroupedFinances, context: ModelContext)
    func createGroupedFinances(_ finances: [Finance])
}

class FinanceViewModel: FinanceViewModelProtocol, ObservableObject {
    @Published var groupedFinances: [GroupedFinances] = []
    @Published var originalGroupedFinances: [GroupedFinances] = []
    @Published var searchText: String = ""
    @Published var addFinance: Bool = false
    @Published var selectedType: FinanceType = .expense
    var allFinances: [Finance] = []
    var allCategories: [Category] = []

    var expenseCategories: [Category] {
        allCategories.filter { category in
            allFinances.contains { $0.financeType == .expense && $0.category == category }
        }
    }

    var incomeCategories: [Category] {
        allCategories.filter { category in
            allFinances.contains { $0.financeType == .income && $0.category == category }
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
        return allFinances.filter { $0.financeType == type }.reduce(0) { $0 + $1.amount }
    }

    func filterFinances(_ text: String) {
        let query = text.lowercased()

        let filteredGroups = self.originalGroupedFinances
            .compactMap { group -> GroupedFinances? in
                let filteredFinances = group.finances.filter {
                    $0.title.lowercased().contains(query) && $0.financeType == self.selectedType
                }
                return filteredFinances.isEmpty ? nil : GroupedFinances(date: group.date, finances: filteredFinances)
            }

        self.groupedFinances = filteredGroups
    }

    func filterFinancesByType(_ type: FinanceType) {
        let filteredGroups = self.originalGroupedFinances
            .compactMap { group -> GroupedFinances? in
                let filteredFinances = group.finances.filter { $0.financeType == type }
                return filteredFinances.isEmpty ? nil : GroupedFinances(date: group.date, finances: filteredFinances)
            }

        self.groupedFinances = filteredGroups
    }

    func resetFilters() {
        if searchText.isEmpty {
            filterFinancesByType(selectedType)
        } else {
            filterFinances(searchText)
        }
    }

    func deleteFinance(_ finances: Finance, from group: GroupedFinances, context: ModelContext) {
        context.delete(finances)
        withAnimation {
            if let groupIndex = groupedFinances.firstIndex(where: { $0.id == group.id }) {
                if let financeIndex = groupedFinances[groupIndex].finances.firstIndex(where: { $0.id == finances.id }) {
                    groupedFinances[groupIndex].finances.remove(at: financeIndex)
                }

                if groupedFinances[groupIndex].finances.isEmpty {
                    groupedFinances.remove(at: groupIndex)
                }
            }
        }
    }

    func createGroupedFinances(_ finances: [Finance]) {
        Task.detached(priority: .high) {
            let groupedDict = Dictionary(grouping: finances) { expense in
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
                self.originalGroupedFinances = sortedDict.compactMap { dict in
                    let date = Calendar.current.date(from: dict.key) ?? .init()
                    return GroupedFinances(date: date, finances: dict.value)
                }
                self.resetFilters()
            }
        }
    }
}

