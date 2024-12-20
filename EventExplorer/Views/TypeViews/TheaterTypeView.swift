//
//  TheaterTypeView.swift
//  EventExplorer
//
//  Created by L S on 12/09/2024.
//

import SwiftUI

// View for displaying theater events by type in the selected country
struct TheaterTypeView: View {
    
    @ObservedObject var viewModel: NearbyEventsViewModel
    @ObservedObject var profileViewModel: ProfileViewModel

    // Array of theater categories to be displayed in the view
    private let theaterCategories = [
        Category(title: "Broadway", imageName: "broadway_type", types: ["broadway"]), // Category for Broadway events
        Category(title: "Comedy", imageName: "comedy_type", types: ["comedy"]), // Category for Comedy events
        Category(title: "Family", imageName: "family_type", types: ["family"]), // Category for Family events
        Category(title: "All Theater Events", imageName: "all_theater_type", types: nil) // Category for all theater events
    ]

    var body: some View {
        NavigationView {
            // CategoryTypeView that displays the theater categories and navigates to the respective views
            CategoryTypeView(
                title: "Theater", // Title for the CategoryTypeView
                categories: theaterCategories, // Passing the theater categories to the view
                destinationView: { category in
                    // Closure to define the destination view for each category
                    TheatreCategoryView(viewModel: viewModel, profileViewModel: profileViewModel, types: category.types)
                }
            )
        }
        .navigationTitle("Theater Events")
        .navigationBarBackButtonHidden(false)
        .environmentObject(profileViewModel)
        .environmentObject(viewModel)
    }
}
