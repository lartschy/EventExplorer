//
//  Performer.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import Foundation

// Represents a performer in an event
struct Performer: Codable {
    
    // Name of the performer
    let name: String
    
    // List of categories (taxonomies) associated with the performer
    let taxonomies: [Taxonomy]

    // Custom key mappings to match the JSON structure
    enum CodingKeys: String, CodingKey {
        case name
        case taxonomies
    }
}


