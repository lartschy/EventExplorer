//
//  Untitled.swift
//  EventExplorer
//
//  Created by L S on 26/10/2024.
//

import SwiftUI
import Combine
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var authError: IdentifiableError?
    @Published var registrationSuccess: Bool = false

    // Function to register a new user
    func register() {
        AuthenticationManager.shared.registerUser(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isAuthenticated = true
                    self?.registrationSuccess = true // Set this to true when registration is successful
                case .failure(let error):
                    self?.authError = IdentifiableError(message: error.localizedDescription)
                    self?.registrationSuccess = false // Reset or set to false on error if needed
                }
            }
        }
    }

    // Function to sign in an existing user
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    print("Sign in error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true) // Sign-in successful
            }
        }

    // Function to sign out a user
    func logout() {
        AuthenticationManager.shared.signOutUser { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isAuthenticated = false
                case .failure(let error):
                    self?.authError = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
}

struct IdentifiableError: Identifiable {
    let id = UUID() // Unique identifier
    let message: String
}

