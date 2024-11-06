//
//  CategoriesViewModel.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 23.07.2024.
//

import SwiftUI
import SwiftData



// MARK: - Protocol
protocol CategoriesViewModelProtocol {
    func fetchCategories(categories: [Category])
    func addNewCategory(context: ModelContext)
    func requestDeleteCategory(_ category: Category)
    func deleteCategory(context: ModelContext)
    func deleteFinance(_ finance: Finance, context: ModelContext)
    func dismissRequestedCategory()
}

final class CategoriesViewModel: ObservableObject, CategoriesViewModelProtocol {
    // MARK: - Published Properties
    @Published var addCategory: Bool = false
    @Published var categoryName: String = ""
    @Published var deleteRequest: Bool = false
    @Published private(set) var requestedCategory: Category?
    @Published private(set) var allCategories: [Category] = []
    
    // MARK: - Dismissing Request
    func dismissRequestedCategory() {
        self.requestedCategory = nil
        self.deleteRequest = false
    }
    
    // MARK: - Fetching Categories
    func fetchCategories(categories: [Category]) {
        allCategories = categories.sorted(by: { ($0.finances?.count ?? 0) > ($1.finances?.count ?? 0) })
    }
    
    // MARK: - Adding New Category
    func addNewCategory(context: ModelContext) {
        let category = Category(categoryName: categoryName)
        context.insert(category)
        categoryName = ""
        addCategory = false
        DataManager.shared.save(context: context)  // Centralized save function
    }
    
    // MARK: - Requesting Deletion of Category
    func requestDeleteCategory(_ category: Category) {
        self.requestedCategory = category
        self.deleteRequest = true
    }
    
    // MARK: - Deleting Category
    func deleteCategory(context: ModelContext) {
        guard let requestedCategory = requestedCategory else { return }
        
        // Delete related financial records
        if let finances = requestedCategory.finances {
            for finance in finances {
                DataManager.shared.delete(finance, context: context)  // Centralized delete function
            }
        }
        
        // Delete the category itself
        DataManager.shared.delete(requestedCategory, context: context)
        self.requestedCategory = nil
    }
    
    // MARK: - Deleting Financial Records
    func deleteFinance(_ finance: Finance, context: ModelContext) {
        DataManager.shared.delete(finance, context: context)
    }
}
