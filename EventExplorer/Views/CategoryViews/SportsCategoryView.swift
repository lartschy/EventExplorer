//
//  SportsCategoryView.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import SwiftUI

// View for displaying sports events by category in the selected country
struct SportsCategoryView: View {
    
    // StateObject to observe and manage the NearbyEventsViewModel, which handles event data fetching
    @StateObject private var viewModel: NearbyEventsViewModel
    
    // ObservedObject for the ProfileViewModel to track the selected country and related data
    @ObservedObject var profileViewModel: ProfileViewModel
    
    // Optional array of event types to further filter sports events (e.g., basketball, soccer, etc.)
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
                // Search bar bound to the ViewModel's search text
                SearchBar(searchText: $viewModel.searchText)
                
                // Country selection picker, bound to the ProfileViewModel's selected country
                Picker("Select Country", selection: $profileViewModel.selectedCountry) {
                    ForEach(profileViewModel.countries, id: \.self) { country in
                        Text(country).tag(country)
                    }
                }
            }
            .padding(.horizontal)
            
            // Scrollable list of sports events
            ScrollView {
                VStack(alignment: .center, spacing: 25) {
                    // Message when no events are available
                    if viewModel.filteredEvents.isEmpty {
                        Text("No Sport Events Available")
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
                viewModel.fetchDataCategoryAndTypes(category: "sports", types: types, for: profileViewModel.selectedCountry)
            }
            .navigationTitle("Sport Events")
            .onAppear {
                // Fetch sports events when the view appears, based on selected country and types
                viewModel.fetchDataCategoryAndTypes(category: "sports", types: types, for: profileViewModel.selectedCountry)
            }
            .onChange(of: profileViewModel.selectedCountry) { newCountry in
                // Fetch sports events again if the selected country changes
                viewModel.fetchDataCategoryAndTypes(category: "sports", types: types, for: newCountry)
            }
        }
    }
}
