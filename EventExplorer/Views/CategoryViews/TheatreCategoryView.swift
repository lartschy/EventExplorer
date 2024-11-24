//
//  TheatreCategoryView.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import SwiftUI

// View for displaying theatre events by category in the selected country
struct TheatreCategoryView: View {
    // Observed ViewModel for managing event data and logic
    @ObservedObject var viewModel: NearbyEventsViewModel
    // Observed ViewModel for managing user profile, including the selected country
    @ObservedObject var profileViewModel: ProfileViewModel
    
    // Optional list of theatre types (e.g., "comedy", "drama")
    let types: [String]?
    
    var body: some View {
        // Reuse the generic EventCategoryView, customized for theatre
        EventCategoryView(
            viewModel: viewModel,                // Pass the event data ViewModel
            profileViewModel: profileViewModel,  // Pass the profile ViewModel
            category: "theater",                 // Specify the category as "theater"
            types: types,                        // Pass optional theatre types
            emptyMessage: "No Theatre Events Available" // Message to show if no events are found
        )
    }
}
