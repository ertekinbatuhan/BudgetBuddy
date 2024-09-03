//
//  FinanceIconView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 28.08.2024.
//

import SwiftUI

// MARK: - FinanceIconView
// A view that displays an icon representing the type of financial transaction.
struct FinanceIconView: View {
    // MARK: - Properties
    let type: FinanceType?
    
    // MARK: - Body
    var body: some View {
        switch type {
        case .income:
            Image(systemName: "arrow.up.circle.fill")
                .foregroundColor(.green)
        case .expense:
            Image(systemName: "arrow.down.circle.fill")
                .foregroundColor(.red)
        default:
            Image(systemName: "questionmark.circle")
                .foregroundColor(.gray)
        }
    }
}
