//
//  EventCategoryView.swift
//  EventExplorer
//
//  Created by L S on 21/11/2024.
//


import SwiftUI

// Displays events for a specific category and allows filtering by type and country
struct EventCategoryView: View {
    // Observed ViewModel for handling event data and logic
    @ObservedObject var viewModel: NearbyEventsViewModel
    // Observed ViewModel for handling user profile, including selected country
    @ObservedObject var profileViewModel: ProfileViewModel
    
    // The name of the category being displayed
    let category: String
    // Optional types within the category (e.g., "basketball" in "sports")
    let types: [String]?
    // Message to display if no events are found
    let emptyMessage: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Search bar and country picker at the top
            HStack {
                // Custom SearchBar component for filtering events
                SearchBar(searchText: $viewModel.searchText)
                
                // Country selection picker
                Picker("Select Country", selection: $profileViewModel.selectedCountry) {
                    // Loop through available countries and create picker options
                    ForEach(profileViewModel.countries, id: \.self) { country in
                        Text(country).tag(country) // Tagging each country option
                    }
                }
                .pickerStyle(MenuPickerStyle()) // Display picker as a dropdown menu
            }
            .padding(.horizontal) // Add padding to the sides
            
            // Scrollable list of events
            ScrollView {
                VStack(alignment: .center, spacing: 25) {
                    // If no events match the criteria, display an empty message
                    if viewModel.filteredEvents.isEmpty {
                        Text(emptyMessage)
                            .font(.headline) // Style as a headline
                            .foregroundColor(.gray) // Use gray color
                            .padding() // Add padding around the text
                    } else {
                        // Loop through filtered events and display each one
                        ForEach(viewModel.filteredEvents, id: \.id) { event in
                            EventRowView(event: event, viewModel: viewModel) // Render individual event row
                        }
                    }
                }
                .padding() // Add padding around the event list
            }
            .refreshable {
                // Fetch updated event data when pulled to refresh
                viewModel.fetchDataCategoryAndTypes(category: category, types: types, for: profileViewModel.selectedCountry)
            }
            .navigationBarBackButtonHidden(true) // Hide the default back button in the navigation bar
            .onAppear {
                // Load events when the view appears
                viewModel.fetchDataCategoryAndTypes(category: category, types: types, for: profileViewModel.selectedCountry)
            }
            .onChange(of: profileViewModel.selectedCountry) { newCountry in
                // Fetch updated events when the selected country changes
                viewModel.fetchDataCategoryAndTypes(category: category, types: types, for: newCountry)
            }
        }
    }
}
