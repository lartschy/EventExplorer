//
//  SportsCategoryView.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import Foundation
import SwiftUI

struct SportsCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: NearbyEventsViewModel
    @State private var selectedCountry: String = "Germany"
    let types: [String]?


    let countries = [
        // America
        "US", "Canada", "Mexico", "Brazil", "Argentina", "Colombia", "Peru", "Chile",
        // Europe
        "United Kingdom", "Germany", "France", "Spain", "Italy", "Netherlands", "Switzerland", "Belgium",
        "Austria", "Sweden", "Norway", "Denmark", "Finland", "Poland", "Greece", "Portugal", "Czech Republic",
        "Ireland", "Hungary", "Romania", "Ukraine", "Slovakia", "Croatia", "Bulgaria", "Lithuania", "Latvia",
        "Estonia", "Slovenia", "Luxembourg", "Malta", "Cyprus"
    ]

    init(viewModel: NearbyEventsViewModel, types: [String]?) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.types = types
    }

    var body: some View {
            VStack(spacing: 0) {
                HStack {
                    SearchBar(searchText: $viewModel.searchText)
                    Picker("Select Country", selection: $selectedCountry) {
                        ForEach(countries, id: \.self) { country in
                            Text(country).tag(country)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.leading, 10)
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(alignment: .center, spacing: 25) {
                        if viewModel.filteredEvents.isEmpty {
                            Text("No Sport Events Available")
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
                .navigationTitle("Sport Events")
                .onAppear {
                    viewModel.fetchDataCategoryAndTypes(category: "sports", types: types, for: selectedCountry)
                }
                .onChange(of: selectedCountry) { newCountry in
                    viewModel.fetchDataCategoryAndTypes(category: "sports", types: types, for: selectedCountry)
                }
            }
        
    }
}



