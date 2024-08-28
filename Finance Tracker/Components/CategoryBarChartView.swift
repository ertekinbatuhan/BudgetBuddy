//
//  CategoryBarChartView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 28.08.2024.
//

import Foundation
import SwiftUI
import Charts

struct CategoryBarChartView: View {
    let categories: [Category]
    let finances: [Finance]
    
    var body: some View {
        Chart {
            ForEach(categories, id: \.self) { category in
              
                BarMark(
                    x: .value("SECTION_CATEGORY", category.categoryName),
                    y: .value("FINANCE_TYPE_INCOME", totalAmount(for: .income, in: category))
                )
                .foregroundStyle(.green)
                
               
                BarMark(
                    x: .value("SECTION_CATEGORY", category.categoryName),
                    y: .value("FINANCE_TYPE_EXPENSE", totalAmount(for: .expense, in: category))
                )
                .foregroundStyle(.red)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartXAxis {
            AxisMarks(values: categories.map { $0.categoryName })
        }
        .padding()
    }
    
    private func totalAmount(for type: FinanceType, in category: Category) -> Double {
        return finances
            .filter { $0.financeType == type && $0.category == category }
            .reduce(0) { $0 + $1.amount }
    }
}
