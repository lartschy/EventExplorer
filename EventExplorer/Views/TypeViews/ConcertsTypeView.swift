//
//  ConcertsTypeView.swift
//  EventExplorer
//
//  Created by L S on 12/09/2024.
//

import SwiftUI

// View for displaying concert events by type in the selected country
struct ConcertsTypeView: View {
    // ViewModel responsible for fetching and managing nearby events
    @StateObject private var viewModel: NearbyEventsViewModel
    
    // ViewModel for managing user profile data
    @ObservedObject var profileViewModel: ProfileViewModel

    // Initializer to set up the view models
    init(viewModel: NearbyEventsViewModel, profileViewModel: ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel) // Initializes the view model as a state object
        self.profileViewModel = profileViewModel // Sets the profile view model as observed
    }

    // Array of concert categories to be displayed in the view
    private let concertCategories = [
        Category(title: "Festival", imageName: "festival_type", types: ["festival"]), // Category for festival events
        Category(title: "Classical", imageName: "classical_type", types: ["classical"]), // Category for classical music events
        Category(title: "Pop", imageName: "pop_type", types: ["pop"]), // Category for pop music events
        Category(title: "All Concerts", imageName: "all_concerts_type", types: nil) // Category for all concert events
    ]

    var body: some View {
        // CategoryTypeView that displays the concert categories and navigates to the respective views
        CategoryTypeView(
            title: "Concert", // Title for the CategoryTypeView
            categories: concertCategories, // Passing the concert categories to the view
            destinationView: { category in
                // Closure to define the destination view for each category
                ConcertsCategoryView(viewModel: viewModel, profileViewModel: profileViewModel, types: category.types)
            }
        )
    }
}

