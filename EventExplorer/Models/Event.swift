//
//  Event.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import Foundation

// Represents an individual event within the SeatGeek API
struct Event: Codable {
    
    // Unique identifier for the event
    let id: Int
    
    // Type of the event (e.g., concert, sports)
    let type: String
    
    // Local date and time of the event
    let datetimeLocal: String
    
    // Venue details for the event
    let venue: Venue
    
    // List of performers participating in the event
    let performers: [Performer]
    
    // URL link to the event's webpage
    let url: String

    // Custom key mappings to match the JSON structure
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case datetimeLocal = "datetime_local"
        case venue
        case performers
        case url
    }
}
