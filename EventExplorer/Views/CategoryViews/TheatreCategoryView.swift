//
//  TheatreCategoryView.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import SwiftUI

struct TheatreCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: NearbyEventsViewModel
    
    // Observing profile view model
    @ObservedObject var profileViewModel: ProfileViewModel
    
    let types: [String]?

    init(viewModel: NearbyEventsViewModel, profileViewModel: ProfileViewModel, types: [String]?) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.profileViewModel = profileViewModel
        self.types = types
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                SearchBar(searchText: $viewModel.searchText)
                Picker("Select Country", selection: $profileViewModel.selectedCountry) {
                    ForEach(profileViewModel.countries, id: \.self) { country in
                        Text(country).tag(country)
                    }
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                VStack(alignment: .center, spacing: 25) {
                    if viewModel.filteredEvents.isEmpty {
                        Text("No Theatre Events Available")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(viewModel.filteredEvents, id: \.id) { event in
                            EventRowView(event: event, viewModel: viewModel)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Theatre Events")
            .onAppear {
                // Fetch events using the selected country from the ProfileViewModel
                viewModel.fetchDataCategoryAndTypes(category: "theater", types: types, for: profileViewModel.selectedCountry)
            }
            .onChange(of: profileViewModel.selectedCountry) { newCountry in
                viewModel.fetchDataCategoryAndTypes(category: "theater", types: types, for: profileViewModel.selectedCountry)
            }
        }
    }
}


