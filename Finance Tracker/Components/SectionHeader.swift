//
//  SectionHeader.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 3.09.2024.
//

import SwiftUI

// MARK: - SectionHeader
// A view that displays a section header with a title.
struct SectionHeader: View {
    // MARK: - Properties
    let title: LocalizedStringKey
    
    // MARK: - Environment
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Body
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .padding(.horizontal)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
