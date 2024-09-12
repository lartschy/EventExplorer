//
//  EventModel+Extensions.swift
//  EventExplorer
//
//  Created by L S on 03/03/2024.
//

import Foundation
import SwiftData

import Foundation

@Model
final class EventModel: Identifiable {
    var id: String
    var type: String
    var datetimeLocal: String
    var url: String
    var address: String
    var city: String
    var country: String
    var venue: String
    var lat: String
    var lon: String
    var name: String
    var category: String

    
    

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

extension EventModel {
    convenience init(from event: Event) {
        let category = event.performers.first?.taxonomies.first?.category ?? "Unknown"
        self.init(
            id: "\(event.id)",
            type: event.type,
            datetimeLocal: event.datetimeLocal,
            url: event.url,
            address: event.venue.address ?? "No address available",
            city: event.venue.city,
            country: event.venue.country,
            venue: event.venue.venue,
            lat: "\(event.venue.location.lat)",
            lon: "\(event.venue.location.lon)",
            name: event.performers.first?.name ?? "Unknown",
            category: category
        )
    }
}



