//
//  SportsTypeView.swift
//  EventExplorer
//
//  Created by L S on 12/09/2024.
//

import SwiftUI

// View for displaying sport events by type in the selected country
struct SportsTypeView: View {
    // ViewModel responsible for fetching and managing nearby events
    @StateObject private var viewModel: NearbyEventsViewModel
    
    // ViewModel for managing user profile data
    @ObservedObject var profileViewModel: ProfileViewModel

    // Initializer to set up the view models
    init(viewModel: NearbyEventsViewModel, profileViewModel: ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel) // Initializes the view model as a state object
        self.profileViewModel = profileViewModel // Sets the profile view model as observed
    }

    // Array of sports categories to be displayed in the view
    private let sportsCategories = [
        Category(title: "Basketball", imageName: "basketball_type", types: ["basketball", "mlb", "wnba"]), // Category for basketball events
        Category(title: "Soccer", imageName: "soccer_type", types: ["soccer", "mls", "ncaa_soccer"]), // Category for soccer events
        Category(title: "American Football", imageName: "football_type", types: ["nfl", "football"]), // Category for American football events
        Category(title: "All Sports", imageName: "all_sports_type", types: nil) // Category for all sports events
    ]

    var body: some View {
        // CategoryTypeView that displays the sports categories and navigates to the respective views
        CategoryTypeView(
            title: "Sport", // Title for the CategoryTypeView
            categories: sportsCategories, // Passing the sports categories to the view
            destinationView: { category in
                // Closure to define the destination view for each category
                SportsCategoryView(viewModel: viewModel, profileViewModel: profileViewModel, types: category.types)
            }
        )
    }
}
