//
//  FinanceIconView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 28.08.2024.
//

import SwiftUI

struct FinanceIconView: View {
    let type: FinanceType?

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
