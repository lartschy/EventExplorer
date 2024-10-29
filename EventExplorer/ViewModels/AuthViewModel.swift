//
//  Untitled.swift
//  EventExplorer
//
//  Created by L S on 26/10/2024.
//

import SwiftUI
import Combine
import FirebaseAuth

// ViewModel responsible for authentication logic
class AuthViewModel: ObservableObject {
    // The user's email address
    @Published var email: String = ""
        
    // The user's password
    @Published var password: String = ""
        
    // Confirm password field
    @Published var passwordAgain: String = ""
        
    // Indicates if the user is authenticated
    @Published var isAuthenticated: Bool = false
        
    // Holds any authentication errors
    @Published var authError: IdentifiableError?

    // Indicates if registration was successful
     @Published var registrationSuccess: Bool = false


    func register() {
        // Check if the email format is valid
        if !isValidEmail(email) {
            self.authError = IdentifiableError(message: "Invalid email format.") // Set error message for invalid email
            return // Exit the function if the email is invalid
        }

        // Check if the password meets minimum length requirements
        if !isValidPassword(password) {
            self.authError = IdentifiableError(message: "Password must be at least 6 characters.") // Set error message for invalid password
            return // Exit the function if the password is too short
        }

        // Check if the password and password confirmation match
        if password != passwordAgain {
            self.authError = IdentifiableError(message: "Passwords do not match.") // Set error message if passwords do not match
            return // Exit the function if the passwords do not match
        }

        // Call the authentication manager to register the user
        AuthenticationManager.shared.registerUser(email: email, password: password) { [weak self] result in
            // Dispatch the result on the main thread to update UI
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isAuthenticated = true // Set authentication status to true on successful registration
                    self?.registrationSuccess = true // Mark registration as successful
                    self?.authError = nil // Clear any existing error messages
                case .failure(let error):
                    self?.authError = IdentifiableError(message: error.localizedDescription) // Set error message based on the failure reason
                    self?.registrationSuccess = false // Mark registration as unsuccessful
                }
            }
        }
    }

    // Helper function to validate email format
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}" // Regular expression for validating email
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex) // Predicate to test the email against the regex
        return emailTest.evaluate(with: email) // Return true if the email matches the regex, false otherwise
    }

    // Helper function to validate password length
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6 // Return true if the password is at least 6 characters long
    }
    
    // Function to sign in an existing user
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        // Use Firebase Auth to sign in the user
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                // Print error message for debugging
                print("Sign in error: \(error.localizedDescription)")
                completion(false) // Notify that sign-in failed
                return
            }
            completion(true) // Sign-in successful
        }
    }

    // Function to sign out a user
    func logout() {
        // Call the AuthenticationManager to sign out the user
        AuthenticationManager.shared.signOutUser { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isAuthenticated = false // Set authenticated status to false
                case .failure(let error):
                    // Capture sign-out error
                    self?.authError = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
}

// Struct to represent identifiable errors
struct IdentifiableError: Identifiable, Equatable {
    let id = UUID()
    let message: String
    
    // Conform to Equatable by comparing the `id` or `message`
    static func == (lhs: IdentifiableError, rhs: IdentifiableError) -> Bool {
        lhs.id == rhs.id && lhs.message == rhs.message
    }
}
