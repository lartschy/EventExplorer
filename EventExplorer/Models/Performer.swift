//
//  Performer.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import Foundation

struct Performer: Codable {
    let name: String
    let taxonomies: [Taxonomy]
    
    enum CodingKeys: String, CodingKey {
        case name, taxonomies
    }
}

