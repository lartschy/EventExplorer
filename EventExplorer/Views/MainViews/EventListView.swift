//
//  EventListView.swift
//  EventExplorer
//
//  Created by L S on 22/02/2024.
//

import Foundation
import SwiftUI

// Main event list view that contains the app's tab navigation
struct EventListView: View {
    // Injecting the environment context and view model for nearby events
    @Environment(\.modelContext) private var modelContext
    @StateObject private var nearbyEventsViewModel = NearbyEventsViewModel()
    @StateObject private var profileViewModel = ProfileViewModel()
    @StateObject private var authViewModel = AuthViewModel()


    var body: some View {
        // Navigation view with tabs for different sections
        NavigationView {
            TabView {
                // Nearby events tab
                NearbyEventsView(viewModel: nearbyEventsViewModel, profileViewModel: profileViewModel)
                    .tabItem {
                        Image(systemName: "safari")
                        Text("Events")
                    }

                // Search events tab
                SearchEventsView(profileViewModel: profileViewModel)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Browse")
                    }

                // Favourites events tab
                FavouriteEventsView(viewModel: nearbyEventsViewModel, profileViewModel: profileViewModel)
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favourites")
                    }

                // User profile tab
                ProfileView(profileViewModel: profileViewModel, authViewModel: authViewModel)
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            .tint(.black) // Set tint color for the tabs
            .navigationBarHidden(true) // Hide the navigation bar for a cleaner look
        }
    }
}


#Preview {
    EventListView()/*.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)*/
        .modelContainer(for: EventModel.self, inMemory: true)
}

