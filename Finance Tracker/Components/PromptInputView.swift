//
//  PromptInputView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 4.09.2024.
//

import SwiftUI

// MARK: - PromptInputView
struct PromptInputView: View {
    @Binding var userPrompt: String
    let onSubmit: () -> Void
    
    var body: some View {
        TextField("PROMPT_PLACEHOLDER_AI", text: $userPrompt, axis: .vertical)
            .lineLimit(6)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemBlue), lineWidth: 1)
            )
            .disableAutocorrection(true)
            .onSubmit {
                onSubmit()
            }
            .padding()
    }
}
