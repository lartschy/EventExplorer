//
//  NearbyEventView.swift
//  EventExplorer
//
//  Created by L S on 01/03/2024.
//

import Foundation
import SwiftUI
import SwiftData

// Nearby events view for listing the event in the selected country of the user
struct NearbyEventsView: View {
    // Environment property to access shared data context (if needed for persistence or Core Data)
    @Environment(\.modelContext) private var modelContext
    
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

                // Scrollable list of events
                ScrollView {
                    VStack(alignment: .center, spacing: 25) {
                        // Loops through filtered events from the ViewModel and displays each event row
                        ForEach(viewModel.filteredEvents, id: \.id) { event in
                            EventRowView(event: event, viewModel: viewModel)  // Event row view for each event
                        }
                    }
                    .padding()
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





