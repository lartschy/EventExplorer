//
//  NearbyEventView.swift
//  EventExplorer
//
//  Created by L S on 01/03/2024.
//

import Foundation
import SwiftUI
import SwiftData

// Nearby events view for listing events in the user's selected country
struct NearbyEventsView: View {
 
    // StateObject to observe the ViewModel for this view
    @StateObject private var viewModel: NearbyEventsViewModel
    
    // Observing profile view model
    @ObservedObject var profileViewModel: ProfileViewModel

    // Custom initializer to inject view models into the view
    init(viewModel: NearbyEventsViewModel, profileViewModel: ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.profileViewModel = profileViewModel // Use ObservedObject for ProfileViewModel
    }
    
    var body: some View {
        // Wraps the content in a NavigationView for navigation and title management
        NavigationView {
            VStack {
                // Show loading indicator if data is still loading
                if viewModel.isLoading {
                    ProgressView("Loading Events...")
                        .padding()
                }
                
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

                // Scrollable list of events with pull-to-refresh
                ScrollView {
                    VStack(alignment: .center, spacing: 25) {
                        if let message = viewModel.emptyStateMessage {
                            // Display the title and subtitle for the empty state
                            Text(message.title)
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding()
                            Text(message.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.accentColor)
                                .padding()
                        } else {
                            // Display events if available
                            ForEach(viewModel.filteredEvents, id: \.id) { event in
                                EventRowView(event: event, viewModel: viewModel)
                            }
                        }
                    }
                    .padding()
                }
                .refreshable {
                    viewModel.fetchData(for: profileViewModel.selectedCountry)
                }
                .navigationTitle("Events")  // Title for the navigation bar
                .onAppear {
                    viewModel.fetchData(for: profileViewModel.selectedCountry) // Fetch events based on selected country
                }
                .onChange(of: profileViewModel.selectedCountry) { newCountry in
                    viewModel.fetchData(for: newCountry)
                }
            }
        }
    }
}
