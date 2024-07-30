//
//  SignInViewModel.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 30.07.2024.
//

import Foundation
import Firebase

class SignInViewModel: ObservableObject {
    
    @Published var isSignedIn: Bool = false
  
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                self.isSignedIn = false
              
                print(error.localizedDescription)
            } else {
                self.isSignedIn = true
              
            }
        }
    }
}
