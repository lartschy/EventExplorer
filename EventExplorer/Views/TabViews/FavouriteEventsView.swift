//
//  FavouriteEventsView.swift
//  EventExplorer
//
//  Created by L S on 18/09/2024.
//

import SwiftUI

// Favourites view to display event categories
struct FavouriteEventsView: View {
    // Environment property to access shared data context (if needed for persistence or Core Data)
    @Environment(\.modelContext) private var modelContext
    
    // StateObject to observe the ViewModel for this view
    @StateObject private var viewModel: NearbyEventsViewModel
    
    // Observing profile view model
    @ObservedObject var profileViewModel: ProfileViewModel

    // Custom initializer to inject view models into the view
    init(viewModel: NearbyEventsViewModel, profileViewModel: ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.profileViewModel = profileViewModel
    }
    
    var body: some View {
        // Wraps the content in a NavigationView for navigation and title management
        NavigationView {
            VStack {
                // Search bar and country picker in a horizontal row
                HStack {
                    // Search bar component, bound to the ViewModel's searchText
                    SearchBar(searchText: $viewModel.searchText)
                    
                    Picker("Select Country", selection: $profileViewModel.selectedCountry) {
                        ForEach(profileViewModel.countries, id: \.self) { country in
                            Text(country).tag(country)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())  // Dropdown style for the picker
                    .padding(.leading, 10)
                }
                .padding(.horizontal)

                // List of favorite events
                let favouriteEvents = viewModel.getFavouriteEvents(from: viewModel.filteredEvents)
                
                ScrollView {
                    if favouriteEvents.isEmpty {
                        Text("No favorite events found.")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        VStack(alignment: .center, spacing: 25) {
                            // Loops through favorite events and displays each event row
                            ForEach(favouriteEvents, id: \.id) { event in
                                EventRowView(event: event, viewModel: viewModel)  // Event row view for each event
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("Favourite Events")  // Title for the navigation bar
                .onAppear {
                    // Any additional logic when the view appears, if needed
                }
                .onChange(of: profileViewModel.selectedCountry) { newCountry in
                    viewModel.fetchData(for: newCountry) // Fetch data based on the selected country
                }
            }
            .padding(.top) // Optional: Adjust top padding as needed
        }
    }
}
