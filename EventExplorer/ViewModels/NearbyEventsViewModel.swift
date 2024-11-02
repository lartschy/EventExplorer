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
    
    // Function to decode JSON string to a dictionary of dictionaries keyed by uid
    private func loadFavourites() -> [String: [String: Bool]] {
        guard let data = favouritesData.data(using: .utf8) else { return [:] }
        let favourites = (try? JSONDecoder().decode([String: [String: Bool]].self, from: data)) ?? [:]
        return favourites
    }

    // Function to encode dictionary to JSON string
    private func saveFavourites(_ favourites: [String: [String: Bool]]) {
        if let data = try? JSONEncoder().encode(favourites),
            let json = String(data: data, encoding: .utf8) {
            favouritesData = json // Save the JSON string to AppStorage
        }
    }

    // Toggle favorite status for an event
    func toggleFavourite(for eventId: String) {
        guard let uid = self.uid else { return }  // Make sure uid is available
        var favourites = loadFavourites()
        var userFavourites = favourites[uid] ?? [:]  // Get favorites for the current user
            
        // Toggle the favorite status
        userFavourites[eventId] = !(userFavourites[eventId] ?? false)
                    
        favourites[uid] = userFavourites // Update favorites for the user
        saveFavourites(favourites) // Save updated favorites
    }

    // Check if an event is a favorite for the current user
    func isFavourite(eventId: String) -> Bool {
        guard let uid = self.uid else { return false }
        let userFavourites = loadFavourites()[uid] ?? [:] // Get user's favorites
        return userFavourites[eventId] ?? false // Return true if event is a favorite
    }

    // Fetch favorite events for the current user
    func getFavouriteEvents(from events: [EventModel]) -> [EventModel] {
        return events.filter { isFavourite(eventId: $0.id) } // Filter events that are marked as favorites
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
        APIService.shared.fetchData(country: country) { [weak self] fetchedEvents in
            // Filter by category
            let filteredEvents = fetchedEvents.filter { $0.category == category }
            DispatchQueue.main.async {
                self?.events = filteredEvents // Update events with filtered data
            }
        }
    }
    
    // Fetch event data filtered by category and types for a specific country
    func fetchDataCategoryAndTypes(category: String, types: [String]? = nil, for country: String) {
        APIService.shared.fetchData(country: country) { [weak self] fetchedEvents in
            let filteredEvents: [EventModel]
            
            // Filter events based on category and optional types
            if let types = types {
                filteredEvents = fetchedEvents.filter { $0.category == category && types.contains($0.type) }
            } else {
                filteredEvents = fetchedEvents.filter { $0.category == category }
            }
            
            DispatchQueue.main.async {
                self?.events = filteredEvents // Update events with filtered data
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

}
