//
//  SeatGeekResponse.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import Foundation

// Represents the root response from the SeatGeek API
struct SeatGeekResponse: Codable {
    
    // An array of event objects retrieved from the API
    let events: [Event]
}
