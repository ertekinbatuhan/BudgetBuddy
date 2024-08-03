//
//  Finance.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 22.07.2024.
//

import Foundation
import SwiftData

@Model
class Finance {
    
    var title: String
    var subTitle: String
    var amount: Double
    var date: Date
    var category: Category?
    var type: String
    
    init(title: String, subTitle: String, amount: Double, date: Date, type: FinanceType, category: Category? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.amount = amount
        self.date = date
        self.type = type.rawValue
        self.category = category
    }
    
    var financeType: FinanceType{
        return FinanceType(rawValue: type) ?? .expense
    }
}
