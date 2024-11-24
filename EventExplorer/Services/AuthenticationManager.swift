//
//  AuthenticationManager.swift
//  EventExplorer
//
//  Created by L S on 26/10/2024.
//

import FirebaseAuth
import Foundation

// Firebase authentication class
class AuthenticationManager {
    
    // Singleton instance of AuthenticationManager
    static let shared = AuthenticationManager()

    // Method to handle user registration
    func registerUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    // Method to handle user sign-in
    func signInUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    // Method to handle user sign-out
    func signOutUser(completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true, completion: { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                do {
                    try Auth.auth().signOut()
                    completion(.success(()))
                } catch let signOutError as NSError {
                    completion(.failure(signOutError))
                }
            }
        })
    }
}
