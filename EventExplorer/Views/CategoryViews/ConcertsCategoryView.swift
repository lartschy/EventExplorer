//
//  ConcertsCategoryView.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import SwiftUI

// View for displaying concert events by category in the selected country
struct ConcertsCategoryView: View {
    // Observed ViewModel for handling event data and logic
    @ObservedObject var viewModel: NearbyEventsViewModel
    // Observed ViewModel for handling user profile, including selected country
    @ObservedObject var profileViewModel: ProfileViewModel
    
    // Optional list of concert types (e.g., "rock", "pop")
    let types: [String]?
    
    var body: some View {
        // Reuse the generic EventCategoryView, customized for concerts
        EventCategoryView(
            viewModel: viewModel,                // Pass the event data ViewModel
            profileViewModel: profileViewModel,  // Pass the profile ViewModel
            category: "concert",                 // Specify the category as "concert"
            types: types,                        // Pass optional concert types
            emptyMessage: "No Concert Events Available" // Message to show if no events are found
        )
    }
}
