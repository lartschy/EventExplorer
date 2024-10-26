//
//  EventModel+Extensions.swift
//  EventExplorer
//
//  Created by L S on 03/03/2024.
//

import Foundation
import SwiftData

// EventModel class representing a locally stored event in the app
@Model
final class EventModel: Identifiable {
    
    // Unique identifier for the event (as String)
    var id: String
    
    // Type of event (e.g., concert, sports)
    var type: String
    
    // Local date and time of the event
    var datetimeLocal: String
    
    // URL link to the event's page
    var url: String
    
    // Address where the event takes place
    var address: String
    
    // City where the event takes place
    var city: String
    
    // Country where the event takes place
    var country: String
    
    // Name of the venue
    var venue: String
    
    // Latitude coordinate of the venue (as String for flexibility)
    var lat: String
    
    // Longitude coordinate of the venue (as String for flexibility)
    var lon: String
    
    // Name of the performer
    var name: String
    
    // Category of the event (e.g., music, sports)
    var category: String
    
    
    // Initializer to create an EventModel instance
    init(id: String, type: String, datetimeLocal: String, url: String, address: String, city: String, country: String, venue: String, lat: String, lon: String, name: String, category: String) {
        self.id = id
        self.type = type
        self.datetimeLocal = datetimeLocal
        self.url = url
        self.address = address
        self.city = city
        self.country = country
        self.venue = venue
        self.lat = lat
        self.lon = lon
        self.name = name
        self.category = category
    }
}

// Extension to initialize EventModel from an Event object
extension EventModel {
    
    // Convenience initializer to convert API Event data to EventModel
    convenience init(from event: Event) {
        
        // Extract the category from the first performer's first taxonomy (default to "Unknown" if not available)
        let category = event.performers.first?.taxonomies.first?.category ?? "Unknown"
        
        // Initialize EventModel using values from the Event struct
        self.init(
            id: "\(event.id)", // Convert event ID to string
            type: event.type,
            datetimeLocal: event.datetimeLocal,
            url: event.url,
            address: event.venue.address ?? "No address available", // Use default if address is nil
            city: event.venue.city,
            country: event.venue.country,
            venue: event.venue.venue,
            lat: "\(event.venue.location.lat)", // Convert latitude to string
            lon: "\(event.venue.location.lon)", // Convert longitude to string
            name: event.performers.first?.name ?? "Unknown", // Use default if performer name is nil
            category: category
        )
    }
}
