//
//  Event.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import Foundation

struct Event: Codable {
    let id: Int
    let type: String
    let datetimeLocal: String
    let venue: Venue
    let performers: [Performer]
    let url: String

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case datetimeLocal = "datetime_local"
        case venue
        case performers
        case url
    }
}
