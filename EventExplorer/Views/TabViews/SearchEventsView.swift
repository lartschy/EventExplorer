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
    @ObservedObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // VStack to display categories for browsing
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        // Sports category
                        CategoryItemView(
                            title: "Sports",
                            imageName: "sports_category",
                            destination: SportsTypeView(
                                viewModel: NearbyEventsViewModel(),
                                profileViewModel: profileViewModel
                            )
                        )
                        
                        // Concerts category
                        CategoryItemView(
                            title: "Concerts",
                            imageName: "music_category",
                            destination: ConcertsTypeView(
                                viewModel: NearbyEventsViewModel(),
                                profileViewModel: profileViewModel
                            )
                        )
                    }
                    
                    HStack(spacing: 20) {
                        // Theater category
                        CategoryItemView(
                            title: "Theatre",
                            imageName: "theatre_category",
                            destination: TheaterTypeView(
                                viewModel: NearbyEventsViewModel(),
                                profileViewModel: profileViewModel
                            )
                        )
                    }
                }
                .padding([.leading, .trailing], 20)
                .padding(.bottom, 30)
            }
            .navigationTitle("Browse Events")
            .navigationBarBackButtonHidden(true)
        }
    }
}

