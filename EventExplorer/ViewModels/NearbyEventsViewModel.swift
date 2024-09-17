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


class NearbyEventsViewModel: ObservableObject {
    @Published var events: [EventModel] = []
    @Published var searchText: String = ""

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

    func fetchData(for country: String) {
        print("fetchData() called for country: \(country)")
        APIService.shared.fetchData(country: country) { [weak self] fetchedEvents in
            print("fetchData() completion block reached")
            DispatchQueue.main.async {
                self?.events = fetchedEvents
            }
        }
    }
    
    func fetchDataCategory(_ category: String, for country: String) {
        APIService.shared.fetchData(country: country) { [weak self] fetchedEvents in
            let filteredEvents = fetchedEvents.filter { $0.category == category }
            DispatchQueue.main.async {
                self?.events = filteredEvents
            }
            print("fetch data block for category:", category)
            for event in fetchedEvents {
                print("Event category:", event.category)
            }
        }
    }
    
    func fetchDataCategoryAndTypes(category: String, types: [String]? = nil, for country: String) {
            APIService.shared.fetchData(country: country) { [weak self] fetchedEvents in
                let filteredEvents: [EventModel]
                
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
    
    func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid Date"
        }
        dateFormatter.dateFormat = "MMM d, yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}
