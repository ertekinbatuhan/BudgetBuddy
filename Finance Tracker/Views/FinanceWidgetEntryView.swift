//
//  FinanceWidgetEntryView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 29.08.2024.
//

import SwiftUI

// MARK: - FinanceWidgetEntryView
struct FinanceWidgetEntryView: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text(NSLocalizedString("GENERAL_TOTAL", comment: "Total amount"))
                    .font(.headline)
                Text(NumberFormatter.currencyFormatter.string(from: NSNumber(value: entry.total)) ?? "\(entry.total)")
                    .font(.largeTitle)
                    .bold()
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 10)
            
            HStack {
                VStack {
                    Image(systemName: "arrow.up.circle.fill")
                        .foregroundColor(.green)
                    Text(NSLocalizedString("FINANCE_TYPE_INCOME", comment: "Income"))
                        .font(.headline)
                    Text(NumberFormatter.currencyFormatter.string(from: NSNumber(value: entry.totalIncome)) ?? "\(entry.totalIncome)")
                        .font(.title2)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                Spacer()
                VStack {
                    Image(systemName: "arrow.down.circle.fill")
                        .foregroundColor(.red)
                    Text(NSLocalizedString("FINANCE_TYPE_EXPENSE", comment: "Expense"))
                        .font(.headline)
                    Text(NumberFormatter.currencyFormatter.string(from: NSNumber(value: entry.totalExpense)) ?? "\(entry.totalExpense)")
                        .font(.title2)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
