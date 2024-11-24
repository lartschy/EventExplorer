//
//  SearchFilteringTests.swift
//  EventExplorer
//
//  Created by L S on 23/10/2024.
//

import XCTest
@testable import EventExplorer

// Test class to test the search functionality within the NearbyEventsViewModel
class SearchFilteringTests: XCTestCase {
    
    // ViewModel instance used for testing.
    var viewModel: NearbyEventsViewModel!
    
    // setUp() method is called before each test. It initializes the ViewModel so we can use it in our tests
    override func setUp() {
        super.setUp()
        viewModel = NearbyEventsViewModel()
    }
    
    // tearDown() method is called after each test to clean up any resources used by the test, such as setting the ViewModel to nil
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // Test method for searching, tests an empty search
    func testFilteredEvents_EmptySearchText() {
        let event1 = EventModel(id: "event1", type: "Concert", datetimeLocal: "2024-10-23T20:00:00", url: "url1", address: "address1", city: "Berlin", country: "Germany", venue: "venue1", lat: "52", lon: "13", name: "Event 1", category: "Music")
        let event2 = EventModel(id: "event2", type: "Basketball", datetimeLocal: "2024-10-23T20:00:00", url: "url2", address: "address2", city: "Berlin", country: "Germany", venue: "venue2", lat: "52", lon: "13", name: "Event 2", category: "Sports")
        
        viewModel.events = [event1, event2]
        viewModel.searchText = ""  // No search term
        
        let filteredEvents = viewModel.filteredEvents
        XCTAssertEqual(filteredEvents.count, 2)  // Both events should be included
    }

    // Test method for searching, tests an specific search expression
    func testFilteredEvents_SearchText() {
        let event1 = EventModel(id: "event1", type: "Concert", datetimeLocal: "2024-10-23T20:00:00", url: "url1", address: "address1", city: "Berlin", country: "Germany", venue: "venue1", lat: "52", lon: "13", name: "Event 1", category: "Music")
        let event2 = EventModel(id: "event2", type: "Basketball", datetimeLocal: "2024-10-23T20:00:00", url: "url2", address: "address2", city: "Berlin", country: "Germany", venue: "venue2", lat: "52", lon: "13", name: "Basketball Game", category: "Sports")

        viewModel.events = [event1, event2]
        viewModel.searchText = "Basketball"
        
        let filteredEvents = viewModel.filteredEvents
        
        // Only event2 should be included
        XCTAssertEqual(filteredEvents.count, 1)
        XCTAssertEqual(filteredEvents.first?.name, "Basketball Game")
    }
    
}
