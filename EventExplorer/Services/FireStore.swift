//
//  FireStore.swift
//  EventExplorer
//
//  Created by L S on 29/04/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FireStore {
    static let shared = FireStore()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    func getUserData() async throws {
        let userRef = db.collection("users")
        
        if let user = Auth.auth().currentUser {
            let document = try await userRef.document(user.uid).getDocument(as: User.self)
            
            print(document)
        } else {
            print("Firebase error")
        }
    }
    
    func saveUser(uid: String, username: String, email: String) async throws {
        try db.collection("users").document(uid).setData(from: User(userName: username, email: email))
    }
}
