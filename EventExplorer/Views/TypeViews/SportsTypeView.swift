//
//  SportsTypeView.swift
//  EventExplorer
//
//  Created by L S on 12/09/2024.
//

import SwiftUI

// View for displaying sport events by type in the selected country
struct SportsTypeView: View {
    @ObservedObject var viewModel: NearbyEventsViewModel
    @ObservedObject var profileViewModel: ProfileViewModel

    // Array of sports categories to be displayed in the view
    private let sportsCategories = [
        Category(title: "Basketball", imageName: "basketball_type", types: ["basketball", "mlb", "wnba", "ncaa_womens_basketball"]),
        Category(title: "Soccer", imageName: "soccer_type", types: ["soccer", "mls", "ncaa_soccer"]),
        Category(title: "American Football", imageName: "football_type", types: ["nfl", "football"]),
        Category(title: "All Sports", imageName: "all_sports_type", types: nil) 
    ]
    
    var body: some View {
        NavigationView {
            CategoryTypeView(
                title: "Sport",
                categories: sportsCategories,
                destinationView: { category in
                    SportsCategoryView(viewModel: viewModel, profileViewModel: profileViewModel, types: category.types)
                }
            )
        }
        .navigationTitle("Sport Events")
        .navigationBarBackButtonHidden(false)
        .environmentObject(profileViewModel)
        .environmentObject(viewModel)
    }
    
}
