//
//  Venue.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import Foundation

// Represents the venue details for an event
struct Venue: Codable {
    
    // Optional address of the venue (may be nil if not provided)
    let address: String?
    
    // City where the venue is located
    let city: String
    
    // Country where the venue is located
    let country: String
    
    // Name of the venue (mapped from "name" in the API)
    let venue: String
    
    // Geographic location details (latitude and longitude)
    let location: Location

    // Custom key mappings to match the JSON structure
    enum CodingKeys: String, CodingKey {
        case address
        case city
        case country
        case venue = "name"
        case location
    }

    // Custom initializer to handle potential missing values
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        address = try? container.decode(String.self, forKey: .address)
        city = try container.decode(String.self, forKey: .city)
        country = try container.decode(String.self, forKey: .country)
        venue = try container.decode(String.self, forKey: .venue)
        location = try container.decode(Location.self, forKey: .location)
    }
}

