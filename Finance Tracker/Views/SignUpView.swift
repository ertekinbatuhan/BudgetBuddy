//
//  SignUpView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 29.07.2024.
//

import SwiftUI
/*
struct SignUpView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var router = false
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var signUpViewModel = SignUpViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer()
                    
                    GeometryReader { geometry in
                        Image("wallet")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.35)
                            .padding(.horizontal)
                            .padding(.top, 100)
                    }
                    .frame(height: 180)
                    
                    Spacer().frame(height: 150)
                    
                    Text("CONVERSATION_TEXT_SIGNUP")
                        .font(.largeTitle)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.bottom, 10)
                    
                    TextField("CONVERSION_TEXT_FIELD_PLACEHOLDER", text: $email)
                        .padding()
                        .background(colorScheme == .dark ? .gray.opacity(0.3) : Color(.systemGray6))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    
                    SecureField("CONVERSION_PASSWORD", text: $password)
                        .padding()
                        .background(colorScheme == .dark ? .gray.opacity(0.3) : Color(.systemGray6))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    
                    NavigationLink(destination: TabBar().navigationBarBackButtonHidden(true), isActive: $signUpViewModel.isSignedUp) {
                        Button(action: {
                            signUpViewModel.createUser(email: email, password: password)
                        }) {
                            Text("CONVERSITION_SIGNUP")
                                .font(.headline)
                                .foregroundColor(colorScheme == .light ? .white : .black)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(colorScheme == .dark ? .white : .black)
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                        }
                        .padding(.top, 15)
                    }
                    
                    OrView(title: "")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.vertical, 15)
                    
                    // Uncomment and configure SocialLoginButton if needed
                    /*
                    HStack(spacing: 20) {
                        SocialLoginButton(iconName: "google", action: {})
                        SocialLoginButton(iconName: "facebook", action: {})
                        SocialLoginButton(iconName: "apple", action: {})
                    }
                    .padding(.horizontal, 30)
                    */
                    
                    // Already have an account?
                    HStack(spacing: 10) {
                        Text("CONVERSATION_ALREADY")
                        NavigationLink(destination: SignInView().navigationBarBackButtonHidden(true), isActive: $router) {
                            Button(action: {
                                router = true
                            }) {
                                Text("CONVERSION_SIGNIN")
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
            .navigationViewStyle(StackNavigationViewStyle())
            } // iPad için Stack stili
        }
    }
}

#Preview {
    SignUpView()
}

*/
