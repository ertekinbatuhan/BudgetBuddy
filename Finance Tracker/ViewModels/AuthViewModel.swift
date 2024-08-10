//
//  AuthViewModel.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 31.07.2024.
//

import Foundation
import Firebase

protocol AuthViewModelProtocol {
    var isUserLoggedIn: Bool { get }
    func checkUserStatus()
    func signOut()
}

class AuthViewModel: ObservableObject , AuthViewModelProtocol {
    
    @Published var isUserLoggedIn: Bool = false

    init() {
        checkUserStatus()
    }

    func checkUserStatus() {
        if Auth.auth().currentUser != nil {
            isUserLoggedIn = true
        } else {
            isUserLoggedIn = false
        }
    }
    
    func signOut() {
           do {
               try Auth.auth().signOut()
               isUserLoggedIn = false
           } catch let signOutError as NSError {
               print("Error signing out", signOutError)
           }
       }
}
