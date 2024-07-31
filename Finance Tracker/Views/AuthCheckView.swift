//
//  AuthCheckView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 31.07.2024.
//

import SwiftUI

struct AuthCheckView: View {
    
    @ObservedObject private var authViewModel = AuthViewModel()

    var body: some View {
        if authViewModel.isUserLoggedIn {
           TabBar()
        } else {
            SignInView()
        }
    }
}
#Preview {
    AuthCheckView()
}
