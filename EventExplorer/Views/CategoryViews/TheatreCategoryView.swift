//
//  TheatreCategoryView.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import SwiftUI

// View for displaying theatre events by category in the selected country
struct TheatreCategoryView: View {
    
    // StateObject to observe and manage the NearbyEventsViewModel, which handles event data fetching
    @StateObject private var viewModel: NearbyEventsViewModel
    
    // ObservedObject for the ProfileViewModel to track the selected country and related data
    @ObservedObject var profileViewModel: ProfileViewModel
    
    // Optional array of event types to further filter theatre events (e.g., plays, musicals, etc.)
    let types: [String]?

    // Custom initializer to inject the ViewModels and event types
    init(viewModel: NearbyEventsViewModel, profileViewModel: ProfileViewModel, types: [String]?) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.profileViewModel = profileViewModel
        self.types = types
    }

    var body: some View {
        VStack(spacing: 0) {
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
            
            // Scrollable list of theatre events
            ScrollView {
                VStack(alignment: .center, spacing: 25) {
                    if viewModel.filteredEvents.isEmpty {
                        Text("No Theatre Events Available")
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
                viewModel.fetchDataCategoryAndTypes(category: "theater", types: types, for: profileViewModel.selectedCountry)
            }
            .navigationTitle("Theatre Events")
            .onAppear {
                // Fetch theatre events based on selected country and types
                viewModel.fetchDataCategoryAndTypes(category: "theater", types: types, for: profileViewModel.selectedCountry)
            }
            .onChange(of: profileViewModel.selectedCountry) { newCountry in
                // Re-fetch events if the selected country changes
                viewModel.fetchDataCategoryAndTypes(category: "theater", types: types, for: newCountry)
            }
        }
    }
}
