//
//  WelcomeMessage.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 4.09.2024.
//

import SwiftUI

// MARK: - WelcomeMessage 
struct WelcomeMessage: View {
    var body: some View {
        Text("WELCOME_MESSAGE_AI")
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(Color(.systemBlue))
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .padding(.top, 40)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
    }
}
