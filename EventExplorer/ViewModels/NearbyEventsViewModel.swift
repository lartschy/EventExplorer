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

// ViewModel responsible for managing and fetching event data
class NearbyEventsViewModel: ObservableObject {
    
    // Published properties to update the SwiftUI views
    @Published var events: [EventModel] = []
    @Published var searchText: String = ""
    
    @AppStorage("favourites") private var favouritesData: String = ""  // Store JSON string

    // Function to decode JSON string to a dictionary
    private func loadFavourites() -> [String: Bool] {
        guard let data = favouritesData.data(using: .utf8) else { return [:] }
        let favourites = (try? JSONDecoder().decode([String: Bool].self, from: data)) ?? [:]
        return favourites
    }

    // Function to encode dictionary to JSON string
    private func saveFavourites(_ favourites: [String: Bool]) {
        if let data = try? JSONEncoder().encode(favourites),
            let json = String(data: data, encoding: .utf8) {
            favouritesData = json
        }
    }

    // Toggle favorite status for an event
    func toggleFavourite(for eventId: String) {
        var favourites = loadFavourites()
        favourites[eventId] = !(favourites[eventId] ?? false)
        saveFavourites(favourites)
    }

    // Check if an event is a favorite
    func isFavourite(eventId: String) -> Bool {
        return loadFavourites()[eventId] ?? false
    }

    // Fetch favorite events
    func getFavouriteEvents(from events: [EventModel]) -> [EventModel] {
        return events.filter { isFavourite(eventId: $0.id) }
    }
    
    // Computed property for filtering events based on search input
    var filteredEvents: [EventModel] {
        if searchText.isEmpty {
            return events
        } else {
            return events.filter { event in
                event.name.localizedCaseInsensitiveContains(searchText) ||
                event.city.localizedCaseInsensitiveContains(searchText) ||
                event.country.localizedCaseInsensitiveContains(searchText) ||
                event.category.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    // Fetch event data for a specific country
    func fetchData(for country: String) {
        print("fetchData() called for country: \(country)")
        APIService.shared.fetchData(country: country) { [weak self] fetchedEvents in
            print("fetchData() completion block reached")
            DispatchQueue.main.async {
                self?.events = fetchedEvents
            }
        }
    }
    
    // Fetch event data filtered by category for a specific country
    func fetchDataCategory(_ category: String, for country: String) {
        APIService.shared.fetchData(country: country) { [weak self] fetchedEvents in
            let filteredEvents = fetchedEvents.filter { $0.category == category }
            DispatchQueue.main.async {
                self?.events = filteredEvents
            }
            print("Fetched data block for category:", category)
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
                self?.events = filteredEvents
            }
            
            print("Fetched events for category:", category, "and types:", types ?? ["All Types"])
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
