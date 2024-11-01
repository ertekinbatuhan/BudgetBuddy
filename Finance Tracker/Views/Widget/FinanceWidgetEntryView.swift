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
                Text(LocalizedStrings.generalTotal.text)
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
                    Image(systemName: FinanceIcons.incomeIcon)
                        .foregroundColor(.green)
                    Text(LocalizedStrings.financeTypeIncome.text)
                        .font(.headline)
                    Text(NumberFormatter.currencyFormatter.string(from: NSNumber(value: entry.totalIncome)) ?? "\(entry.totalIncome)")
                        .font(.title2)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                Spacer()
                VStack {
                    Image(systemName: FinanceIcons.expenseIcon)
                        .foregroundColor(.red)
                    Text(LocalizedStrings.financeTypeExpense.text)
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
