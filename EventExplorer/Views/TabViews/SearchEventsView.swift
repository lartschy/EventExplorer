//
//  SearchEventsView.swift
//  EventExplorer
//
//  Created by L S on 01/03/2024.
//

import Foundation
import SwiftUI

// Search view to display event categories
struct SearchEventsView: View {
    @State private var searchText = ""
    @ObservedObject var profileViewModel: ProfileViewModel

    
    // Events to be displayed (currently unused)
    @State private var events: [EventModel] = []

    var body: some View {
        NavigationView {
            VStack {
                // Vertical stack to display categories for browsing
                VStack(spacing: 20) {
                    // First row: sports and concerts
                    HStack(spacing: 20) {
                        // Navigates to sports category when clicked
                        NavigationLink(destination: SportsTypeView(viewModel: NearbyEventsViewModel(), profileViewModel: profileViewModel)) {
                            Text("Sports")
                                .categoryText(imageName: "sports_category")  // Reusable category text styling
                        }
                        // Navigates to concerts category
                        NavigationLink(destination: ConcertsTypeView(viewModel: NearbyEventsViewModel(), profileViewModel: profileViewModel)) {
                            Text("Concerts")
                                .categoryText(imageName: "music_category")
                        }
                    }
                    // Second row: theater
                    HStack(spacing: 20) {
                        NavigationLink(destination: TheaterTypeView(viewModel: NearbyEventsViewModel(), profileViewModel: profileViewModel)) {
                            Text("Theatre")
                                .categoryText(imageName: "theatre_category")
                        }
                    }
                }
                .padding([.leading, .trailing], 20)
                .padding(.bottom, 30)
            }
            .navigationTitle("Browse Events")  // Title for the view
            .navigationBarBackButtonHidden(true)  // Hides the back button in the navigation bar
        }
    }
}

