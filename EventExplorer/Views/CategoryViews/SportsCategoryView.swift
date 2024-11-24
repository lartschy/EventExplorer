//
//  SportsCategoryView.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import SwiftUI

// View for displaying sports events by category in the selected country
struct SportsCategoryView: View {
    // Observed ViewModel for managing event data and logic
    @ObservedObject var viewModel: NearbyEventsViewModel
    // Observed ViewModel for managing user profile, including the selected country
    @ObservedObject var profileViewModel: ProfileViewModel
    
    // Optional list of sport types (e.g., "football", "basketball")
    let types: [String]?
    
    var body: some View {
        // Reuse the generic EventCategoryView, customized for sports
        EventCategoryView(
            viewModel: viewModel,                // Pass the event data ViewModel
            profileViewModel: profileViewModel,  // Pass the profile ViewModel
            category: "sports",                  // Specify the category as "sports"
            types: types,                        // Pass optional sports types
            emptyMessage: "No Sport Events Available" // Message to show if no events are found
        )
    }
}
