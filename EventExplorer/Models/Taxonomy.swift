//
//  Taxonomy.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import Foundation

struct Taxonomy: Codable {
    let category: String
    private enum CodingKeys: String, CodingKey {
        case category = "name"
    }
}
