//
//  FinanceWidgetEntryView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 29.08.2024.
//

import SwiftUI

// MARK: - FinanceWidgetEntryView
struct FinanceWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text("Toplam")
                    .font(.headline)
                Text("\(entry.total, format: .currency(code: "TRY"))")
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
                    Text("Gelir")
                        .font(.headline)
                    Text("\(entry.totalIncome, format: .currency(code: "TRY"))")
                        .font(.title2)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                Spacer()
                VStack {
                    Image(systemName: "arrow.down.circle.fill")
                        .foregroundColor(.red)
                    Text("Gider")
                        .font(.headline)
                    Text("\(entry.totalExpense, format: .currency(code: "TRY"))")
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
