//
//  EventCategoryView.swift
//  EventExplorer
//
//  Created by L S on 21/11/2024.
//


import SwiftUI

struct EventCategoryView: View {
    @ObservedObject var viewModel: NearbyEventsViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    
    let category: String
    let types: [String]?
    let emptyMessage: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Search and country picker
            HStack {
                SearchBar(searchText: $viewModel.searchText)
                
                Picker("Select Country", selection: $profileViewModel.selectedCountry) {
                    ForEach(profileViewModel.countries, id: \.self) { country in
                        Text(country).tag(country)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.horizontal)
            
            // List of events
            ScrollView {
                VStack(alignment: .center, spacing: 25) {
                    if viewModel.filteredEvents.isEmpty {
                        Text(emptyMessage)
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
            .refreshable {
                viewModel.fetchDataCategoryAndTypes(category: category, types: types, for: profileViewModel.selectedCountry)
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                viewModel.fetchDataCategoryAndTypes(category: category, types: types, for: profileViewModel.selectedCountry)
            }
            .onChange(of: profileViewModel.selectedCountry) { newCountry in
                viewModel.fetchDataCategoryAndTypes(category: category, types: types, for: newCountry)
            }
        }
    }
}
