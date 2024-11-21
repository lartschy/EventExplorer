//
//  ConcertsCategoryView.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import SwiftUI

// View for displaying concert events by category in the selected country
struct ConcertsCategoryView: View {
    
    // StateObject to observe and manage the NearbyEventsViewModel, which handles event data fetching
    @StateObject private var viewModel: NearbyEventsViewModel
    
    // ObservedObject for the ProfileViewModel to track the selected country and related data
    @ObservedObject var profileViewModel: ProfileViewModel
    
    // Optional array of event types to further filter concerts (e.g., rock, pop, jazz, etc.)
    let types: [String]?

    // Custom initializer to inject the ViewModels and event types
    init(viewModel: NearbyEventsViewModel, profileViewModel: ProfileViewModel, types: [String]?) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.profileViewModel = profileViewModel
        self.types = types
    }

    var body: some View {
        VStack {
            // Top section with search bar and country picker
            HStack {
                SearchBar(searchText: $viewModel.searchText)
                
                // Country selection picker, bound to the ProfileViewModel's selected country
                Picker("Select Country", selection: $profileViewModel.selectedCountry) {
                    ForEach(profileViewModel.countries, id: \.self) { country in
                        Text(country).tag(country)
                    }
                }
            }
            .padding(.horizontal)
            
            // Scrollable list of concert events
            ScrollView {
                VStack(alignment: .center, spacing: 25) {
                    if viewModel.filteredEvents.isEmpty {
                        Text("No Concert Events Available")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        // Display each event in an EventRowView
                        ForEach(viewModel.filteredEvents, id: \.id) { event in
                            EventRowView(event: event, viewModel: viewModel)
                        }
                    }
                }
                .padding()
            }
            .refreshable {
                viewModel.fetchDataCategoryAndTypes(category: "concert", types: types, for: profileViewModel.selectedCountry)
            }
            .navigationTitle("Concert Events")
            .onAppear {
                // Fetch concert events based on selected country and types
                viewModel.fetchDataCategoryAndTypes(category: "concert", types: types, for: profileViewModel.selectedCountry)
            }
            .onChange(of: profileViewModel.selectedCountry) { newCountry in
                // Re-fetch events if the selected country changes
                viewModel.fetchDataCategoryAndTypes(category: "concert", types: types, for: newCountry)
            }
        }
    }
}
