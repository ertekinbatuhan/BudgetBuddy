//
//  SignUpView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 29.07.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email = ""
    @State private var password = ""
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var signUpViewModel = SignUpViewModel()

    var body: some View {
        GeometryReader { geometry in
           NavigationView {
                VStack {
                    
                    Spacer()
                   
                    Image("wallet")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.35)
                        .padding(.horizontal)
                        .padding(.top,5)
                    
                    Spacer().frame(height: 40)  
                    
                    Text("Sign Up")
                        .font(.largeTitle)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.bottom, 10)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(colorScheme == .dark ? .gray.opacity(0.3) : Color(.systemGray6))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(colorScheme == .dark ? .gray.opacity(0.3) : Color(.systemGray6))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    
                    NavigationLink(destination: TabBar().navigationBarBackButtonHidden(true), isActive: $signUpViewModel.isSignedUp) {
                        Button(action: {
                            
                            signUpViewModel.createUser(email: email, password: password)
                        }) {
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(colorScheme == .light ? .white : .black)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(colorScheme == .dark ? .white : .black)
                                .cornerRadius(10)
                                .padding(.horizontal, 30)
                        }
                    .padding(.top, 15)
                    }
                    
                    OrView(title: "or")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.vertical, 15)
                    
                    HStack(spacing: 20) {
                        SocialLoginButton(iconName: "google", action: {
                            
                        })
                        
                        SocialLoginButton(iconName: "facebook", action: {
                            
                        })
                        
                        SocialLoginButton(iconName: "apple", action: {
                            
                        })
                    }
                    .padding(.horizontal, 30)
                    
                    HStack(spacing : 10){
                        
                        Text("Already have an account?")
                        
                        Button() {
                            
                        } label : {
                            Text("Sign In")
                                .foregroundColor(colorScheme == .dark ? .blue : .blue)
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
}

#Preview {
   SignUpView()
}

