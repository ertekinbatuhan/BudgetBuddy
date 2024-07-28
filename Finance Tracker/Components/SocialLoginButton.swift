//
//  SocialLoginButton.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 28.07.2024.
//

import SwiftUI

struct SocialLoginButton: View {
    var iconName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(iconName)
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
        }
    }
}

