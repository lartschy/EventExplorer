//
//  Untitled.swift
//  EventExplorer
//
//  Created by L S on 26/10/2024.
//

import SwiftUI
import Combine
import FirebaseAuth
import Network

// ViewModel responsible for authentication logic
class AuthViewModel: ObservableObject {
    // The user's email address and password
    @Published var email: String = ""
    @Published var password: String = ""
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
            self.authError = IdentifiableError(message: "Invalid email format.")
            return
        }

        // Check if the password meets minimum length requirements
        if !isValidPassword(password) {
            self.authError = IdentifiableError(message: "Password must be at least 6 characters.")
            return
        }

        // Check if the password and password confirmation match
        if password != passwordAgain {
            self.authError = IdentifiableError(message: "Passwords do not match.")
            return
        }

        // Call the authentication manager to register the user
        AuthenticationManager.shared.registerUser(email: email, password: password) { [weak self] result in
            // Dispatch the result on the main thread to update UI
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isAuthenticated = true
                    self?.registrationSuccess = true
                    self?.authError = nil
                case .failure(let error):
                    self?.authError = IdentifiableError(message: error.localizedDescription)
                    self?.registrationSuccess = false
                }
            }
        }
    }

    // Helper function to validate email format
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }

    // Helper function to validate password length
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    // Function to check network connectivity once and stop monitoring
    func isConnectedToNetwork(completion: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        
        monitor.pathUpdateHandler = { path in
            completion(path.status == .satisfied)
            monitor.cancel()
        }
        monitor.start(queue: queue)
    }

    // Sign-in function with network check
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        isConnectedToNetwork { isConnected in
            guard isConnected else {
                // Update authError on the main thread if there's no internet connection
                DispatchQueue.main.async {
                    self.authError = IdentifiableError(message: "No internet connection. Please check your network and try again.")
                }
                completion(false)
                return
            }

            // Call AuthenticationManager's signInUser function
            AuthenticationManager.shared.signInUser(email: email, password: password) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        completion(true) // Sign-in successful
                    case .failure(let error):
                        print("Sign in error: \(error.localizedDescription)")
                        // Set error message for incorrect email or password
                        self.authError = IdentifiableError(message: "Incorrect email or password.")
                        completion(false)
                    }
                }
            }
        }
    }

    
    // Function to sign out a user
    func logout() {
        // Call the AuthenticationManager to sign out the user
        AuthenticationManager.shared.signOutUser { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isAuthenticated = false
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
