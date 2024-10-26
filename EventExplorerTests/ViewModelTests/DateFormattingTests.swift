//
//  DateFormattingTests.swift
//  EventExplorer
//
//  Created by L S on 23/10/2024.
//

import XCTest
@testable import EventExplorer

// Test class to test the date formatting functionality within the NearbyEventsViewModel
class DateFormattingTests: XCTestCase {
    
    // ViewModel instance used for testing
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
    
    // Test method for date formatting, tests both a valid date string and an invalid one
    func testFormatDate() {
        // A properly formatted date string
        let validDateString = "2024-10-23T20:00:00"
        
        // An incorrectly formatted date string
        let invalidDateString = "Invalid Date String"
        
        // Check if the valid date string is formatted correctly. The expected format is "Oct 23, 2024 20:00"
        XCTAssertEqual(viewModel.formatDate(validDateString), "Oct 23, 2024 20:00")
        
        // Check if the invalid date string returns the expected fallback value, which is "Invalid Date"
        XCTAssertEqual(viewModel.formatDate(invalidDateString), "Invalid Date")
    }
}
