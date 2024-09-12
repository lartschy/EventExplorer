//
//  EventViewModel.swift
//  EventExplorer
//
//  Created by L S on 03/03/2024.
//

import Foundation

class EventViewModel: ObservableObject {
    @Published var events: [EventModel]
    @Published var searchText: String = ""

    init(events: [EventModel]) {
        self.events = events
    }

    func filteredEvents() -> [EventModel] {
        guard !searchText.isEmpty else {
            return events
        }

        return events.filter { event in
            event.name.localizedCaseInsensitiveContains(searchText) ||
            event.city.localizedCaseInsensitiveContains(searchText) ||
            event.country.localizedCaseInsensitiveContains(searchText) ||
            event.category.localizedCaseInsensitiveContains(searchText)
        }
    }
}
