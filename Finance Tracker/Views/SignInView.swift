//
//  SignInView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 28.07.2024.
//

import SwiftUI

struct SignInView: View {
    
    @State  private var email = ""
    @State  private var password = ""
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        GeometryReader { geometry in
            
            NavigationStack {
                VStack {
                    
                    Spacer()
                   
                    Image("signIn")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.35)
                        .padding(.horizontal)
                        .padding(.top,25)
                    
                    Spacer().frame(height: 40)
                    
                    Text("Sign In")
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
                    
                    Button(action: {
                      
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(colorScheme == .light ? .white : .black)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(colorScheme == .dark ? .white : .black)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                    }
                    .padding(.top, 15)
                    
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
                        
                        Text("Don't have an account?")
                        
                        Button() {
                            
                        } label : {
                            Text("Sign Up")
                                .foregroundColor(colorScheme == .dark ? .blue : .blue)
                        }
                    }.padding()
                    
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
    SignInView()
}

