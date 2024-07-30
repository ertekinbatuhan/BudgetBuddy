//
//  SignUpViewModel.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 30.07.2024.
//

import Foundation
import Firebase

class SignUpViewModel : ObservableObject {
    
    @Published var isSignedUp: Bool = false

    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.isSignedUp = false
                print(error.localizedDescription)
            } else {
                self.isSignedUp = true
            }
        }
    }
}
