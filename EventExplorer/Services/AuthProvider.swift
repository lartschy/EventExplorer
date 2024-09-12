//
//  AuthProvider.swift
//  EventExplorer
//
//  Created by L S on 29/04/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AuthProvider {
    static let shared = AuthProvider()
    private let auth = Auth.auth()
    private init() {}
    
    func register(username: String, email: String, password: String) async throws {
        let ref = try await auth.createUser(withEmail: email, password: password)
        try await FireStore.shared.saveUser(uid: ref.user.uid, username: username, email: email)
        try await FireStore.shared.getUserData()
    }
    
    func login(email: String, password: String) async throws {
        try await auth.signIn(withEmail: email, password: password)
        try await FireStore.shared.getUserData()
    }
}
