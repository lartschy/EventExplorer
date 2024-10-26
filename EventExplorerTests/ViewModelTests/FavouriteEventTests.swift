//
//  FavouriteEventTests.swift
//  EventExplorer
//
//  Created by L S on 23/10/2024.
//

import XCTest
@testable import EventExplorer

class FavouriteEventTests: XCTestCase {
    
    // ViewModel instance used for testing
    var viewModel: NearbyEventsViewModel!

    // setUp() method is called before each test
    override func setUp() {
        super.setUp()
        viewModel = NearbyEventsViewModel()
        
        // Clear the AppStorage value before each test
        UserDefaults.standard.removeObject(forKey: "favourites")
    }
    
    // tearDown() method is called after each test
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // Testing functionality of adding and removing favourite events
    func testToggleFavourite() {
        // Initially, the event should not be a favorite
        let eventId = "event123"
        XCTAssertFalse(viewModel.isFavourite(eventId: eventId), "Event should not be a favorite initially.")
        
        // Toggle it to make it a favorite
        viewModel.toggleFavourite(for: eventId)
        XCTAssertTrue(viewModel.isFavourite(eventId: eventId), "Event should be marked as favorite after toggling.")
        
        // Toggle it again to unfavorite
        viewModel.toggleFavourite(for: eventId)
        XCTAssertFalse(viewModel.isFavourite(eventId: eventId), "Event should not be a favorite after toggling again.")
    }

    // Test getting favourite events
    func testGetFavouriteEvents() {
        let event1 = EventModel(id: "event1", type: "Concert", datetimeLocal: "2024-10-23T20:00:00", url: "url1", address: "address1", city: "Berlin", country: "Germany", venue: "venue1", lat: "52", lon: "13", name: "Event 1", category: "Music")
        let event2 = EventModel(id: "event2", type: "Basketball", datetimeLocal: "2024-10-23T20:00:00", url: "url2", address: "address2", city: "Berlin", country: "Germany", venue: "venue2", lat: "52", lon: "13", name: "Event 2", category: "Sports")
        
        viewModel.toggleFavourite(for: event1.id)  // Mark event1 as favorite
        
        let favouriteEvents = viewModel.getFavouriteEvents(from: [event1, event2])
        
        // Only event1 should be in the favorites
        XCTAssertEqual(favouriteEvents.count, 1, "Only event1 should be in the favorites.")
        XCTAssertEqual(favouriteEvents.first?.id, event1.id, "The favorite event should be event1.")
    }
}

