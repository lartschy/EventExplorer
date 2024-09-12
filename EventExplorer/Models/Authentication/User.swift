//
//  User.swift
//  EventExplorer
//
//  Created by L S on 29/04/2024.
//

import Foundation

struct User: Codable {
    var userName: String
    let email: String
    var favourites: [String] = []
    
    init(userName: String, email: String) {
        self.userName = userName
        self.email = email
    }
}
