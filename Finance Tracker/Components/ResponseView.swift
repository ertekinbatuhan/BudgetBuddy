//
//  ResponseView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 4.09.2024.
//

import SwiftUI

// MARK: - ResponseView
struct ResponseView: View {
    let response: LocalizedStringKey
    let isLoading: Bool
    
    var body: some View {
        ScrollView {
            Text(response)
                .font(.title2)
                .padding()
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding()
        }
    }
}
