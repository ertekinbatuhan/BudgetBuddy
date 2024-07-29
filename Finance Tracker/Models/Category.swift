//
//  Category.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 22.07.2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Category {
    var categoryName: String
    @Relationship(deleteRule: .cascade, inverse: \Expense.category)
    var expenses : [Expense]?
    
    init(categoryName: String) {
        self.categoryName = categoryName
    }
}
