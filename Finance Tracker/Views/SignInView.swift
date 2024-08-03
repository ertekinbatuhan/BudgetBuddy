//
//  SignInView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 28.07.2024.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var router = false
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private var signInViewModel = SignInViewModel()

    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                
                GeometryReader { geometry in
                    Image("signIn")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.35)
                        .padding(.horizontal)
                        .padding(.top, 100)
                }
                .frame(height: 210)
                
                Spacer().frame(height: 100)
                
                Text("Sign In")
                    .font(.largeTitle)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.bottom, 10)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(colorScheme == .dark ? .gray.opacity(0.3) : Color(.systemGray6))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(colorScheme == .dark ? .gray.opacity(0.3) : Color(.systemGray6))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                
                NavigationLink(destination: TabBar().navigationBarBackButtonHidden(true), isActive: $signInViewModel.isSignedIn) {
                    Button(action: {
                        signInViewModel.signIn(email: email, password: password)
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(colorScheme == .light ? .white : .black)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(colorScheme == .dark ? .white : .black)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                }
                .padding(.top, 15)
                
                OrView(title: "or")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.vertical, 15)
                
                HStack(spacing: 20) {
                    SocialLoginButton(iconName: "google", action: {})
                    SocialLoginButton(iconName: "facebook", action: {})
                    SocialLoginButton(iconName: "apple", action: {})
                }
                .padding(.horizontal, 30)
                
                HStack(spacing : 10){
                    Text("Don't have an account?")
                    
                    NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true), isActive: $router) {
                        Button(action: {
                            router = true
                        }) {
                            Text("Sign Up")
                                .foregroundColor(colorScheme == .dark ? .blue : .blue)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    SignInView()
}
