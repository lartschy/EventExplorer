//
//  Taxonomy.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import Foundation

// Represents a category or classification for a performer
struct Taxonomy: Codable {
    
    // Name of the category (mapped from "name" in the API)
    let category: String

    // Custom key mapping to match the JSON structure
    private enum CodingKeys: String, CodingKey {
        case category = "name"
    }
}
