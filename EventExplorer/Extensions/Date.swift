//
//  Date.swift
//  EventExplorer
//
//  Created by L S on 23/09/2024.
//

import Foundation

// Extension for Date to provide reusable formatting methods
extension Date {
    
    // Static method to convert a string to a Date object
    static func from(_ dateString: String, format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }

    // Method to convert a Date object to a formatted string
    func toString(format: String = "MMM d, yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
