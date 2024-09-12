//
//  Venue.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import Foundation

struct Venue: Codable {
    let address: String?
    let city: String
    let country: String
    let venue: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case address
        case city
        case country
        case venue = "name"
        case location
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        address = try? container.decode(String.self, forKey: .address)
        city = try container.decode(String.self, forKey: .city)
        country = try container.decode(String.self, forKey: .country)
        venue = try container.decode(String.self, forKey: .venue)
        location = try container.decode(Location.self, forKey: .location)
    }
}
