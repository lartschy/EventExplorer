//
//  NearbyEventsViewModel.swift
//  EventExplorer
//
//  Created by L S on 01/03/2024.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation
import FirebaseAuth
import MapKit

// ViewModel responsible for managing and fetching event data
class NearbyEventsViewModel: ObservableObject {
    
    // Published properties to update the SwiftUI views
    @Published var events: [EventModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    // Store JSON string
    @AppStorage("favourites") private var favouritesData: String = ""
    
    // Store the user ID (uid) here
    private var uid: String?
    
    // Initialize with the Firebase uid
    init() {
        self.uid = Auth.auth().currentUser?.uid
    }
    
    // Computed property for filtering events based on search input
    var filteredEvents: [EventModel] {
        if searchText.isEmpty {
            return events // Return all events if no search text
        } else {
            return events.filter { event in
                // Filter events based on search text matching name, city, country, or category
                event.name.localizedCaseInsensitiveContains(searchText) ||
                event.city.localizedCaseInsensitiveContains(searchText) ||
                event.country.localizedCaseInsensitiveContains(searchText) ||
                event.category.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    // Determines the message to show if no events match the filter
    var emptyStateMessage: (title: String, subtitle: String)? {
        if filteredEvents.isEmpty {
            if searchText.isEmpty {
                return ("No Events Available Currently", "Try again later")
            } else {
                return ("No results found for '\(searchText)'", "Try searching for something else")
            }
        }
        return nil
    }
    
    // Function to decode JSON string to a dictionary of dictionaries keyed by uid
    private func loadFavourites() -> [String: [String: Bool]] {
        // Convert AppStorage data to Data object
        guard let data = favouritesData.data(using: .utf8) else { return [:] }
        
        // Decode the data
        let favourites = (try? JSONDecoder().decode([String: [String: Bool]].self, from: data)) ?? [:]
        return favourites
    }
    
    // Check if an event is a favorite for the current user
    func isFavourite(eventId: String) -> Bool {
        guard let uid = self.uid else { return false }
        
        // Get user's favorites
        let userFavourites = loadFavourites()[uid] ?? [:]
        
        // Return true if event is a favorite
        return userFavourites[eventId] ?? false
    }

    // Fetch favorite events for the current user
    func getFavouriteEvents(from events: [EventModel]) -> [EventModel] {
        // Filter events that are marked as favorites
        return events.filter { isFavourite(eventId: $0.id) }
    }
    
    // Toggle favorite status for an event
    func toggleFavourite(for eventId: String) {
        // Make sure uid is available
        guard let uid = self.uid else { return }
        
        // Leading favourite events
        var favourites = loadFavourites()
        
        // Get favorites for the current user
        var userFavourites = favourites[uid] ?? [:]
            
        // Toggle the favorite status
        userFavourites[eventId] = !(userFavourites[eventId] ?? false)
                    
        // Update favorites for the user, save updated favorites
        favourites[uid] = userFavourites
        saveFavourites(favourites)
    }

    // Function to encode dictionary to JSON string
    private func saveFavourites(_ favourites: [String: [String: Bool]]) {
        // Convert to JSON text
        if let data = try? JSONEncoder().encode(favourites),
           // Convert to string for AppStorage
           let json = String(data: data, encoding: .utf8) {
                // Save the string to AppStorage
                favouritesData = json
        }
    }
    
    // Fetch event data for a specific country
    func fetchData(for country: String) {
        // Start loading indicator
        self.isLoading = true
        
        APIService.shared.fetchData(country: country) { [weak self] fetchedEvents in
            DispatchQueue.main.async {
                // Update events with fetched data
                self?.events = fetchedEvents
                // Stop loading indicator
                self?.isLoading = false
            }
        }
    }
    
    // Fetch event data filtered by category for a specific country
    func fetchDataCategory(_ category: String, for country: String) {
        // Start loading indicator
        self.isLoading = true
        
        APIService.shared.fetchData(country: country) { [weak self] fetchedEvents in
            // Filter by category
            let filteredEvents = fetchedEvents.filter { $0.category == category }
            DispatchQueue.main.async {
                // Update events with filtered data
                self?.events = filteredEvents
                // Stop loading indicator
                self?.isLoading = false
            }
        }
    }
    
    // Fetch event data filtered by category and types for a specific country
    func fetchDataCategoryAndTypes(category: String, types: [String]? = nil, for country: String) {
        // Start loading indicator
        self.isLoading = true
        
        APIService.shared.fetchData(country: country) { [weak self] fetchedEvents in
            
            // Filter events based on category and optional types
            let filteredEvents = types != nil
                    ? fetchedEvents.filter { $0.category == category && types!.contains($0.type) }
                    : fetchedEvents.filter { $0.category == category }
                    
            
            DispatchQueue.main.async {
                // Update events with filtered data
                self?.events = filteredEvents
                // Stop loading indicator
                self?.isLoading = false
            }
        }
    }
    
    // Formats a date string into a more readable format
    func formatDate(_ dateString: String) -> String {
        
        // Attempt to convert the input date string into a Date object
        guard let date = Date.from(dateString) else {
            // Return a default message if the date conversion fails
            return "Invalid Date"
        }
        
        // Convert the Date object into a formatted string and return it
        return date.toString()
    }
    
    // Formats the type string
    func formatType(_ type: String) -> String {
        type
            .replacingOccurrences(of: "_", with: " ") // Replace underscores with spaces
            .split(separator: " ") // Split the string into words
            .map { $0.capitalized } // Capitalize each word
            .joined(separator: " ") // Join the words back into a single string
    }
    
    // Computes the map region centered on the event's latitude and longitude
    func computeMapRegion(for event: EventModel) -> MKCoordinateRegion {
        // Convert the event's lat/lon strings to Double values; default to 0 if conversion fails
        let latitude = Double(event.lat) ?? 0.0
        let longitude = Double(event.lon) ?? 0.0
        
        // Convert the event's lat/lon strings to Double values; default to 0 if conversion fails
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }

    // Opens the address in the selected map app
    func openAddressInMap(for event: EventModel, app: String) {
        // Convert address to fit the URL
        let address = event.address.replacingOccurrences(of: " ", with: "+")
        
        // Make the search query
        let query = "\(event.venue), \(event.city), \(event.country)"
        
        let urlString: String
        
        // Make the final URL
        switch app {
        case "Apple Maps":
            urlString = "http://maps.apple.com/?q=\(query)"
        case "Google Maps":
            urlString = "comgooglemaps://?q=\(query)"
        default:
            return
        }

        // Open the application
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if app == "Google Maps" {
            // Fallback to Google Maps website if the app is not installed
            if let webURL = URL(string: "https://www.google.com/maps/search/?api=1&query=\(address)") {                   UIApplication.shared.open(webURL)
            }
        }
    }
}


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
