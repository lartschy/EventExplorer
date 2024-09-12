//
//  NearbyEventView.swift
//  EventExplorer
//
//  Created by L S on 01/03/2024.
//

import Foundation
import SwiftUI
import SwiftData

struct NearbyEventsView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: NearbyEventsViewModel
    @State private var selectedCountry: String = "Germany"

    let countries = [
        // America
        "US", "Canada", "Mexico", "Brazil", "Argentina", "Colombia", "Peru", "Chile",
        // Europe
        "United Kingdom", "Germany", "France", "Spain", "Italy", "Netherlands", "Switzerland", "Belgium",
        "Austria", "Sweden", "Norway", "Denmark", "Finland", "Poland", "Greece", "Portugal", "Czech Republic",
        "Ireland", "Hungary", "Romania", "Ukraine", "Slovakia", "Croatia", "Bulgaria", "Lithuania", "Latvia",
        "Estonia", "Slovenia", "Luxembourg", "Malta", "Cyprus"
    ]

    init(viewModel: NearbyEventsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
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
                        ForEach(viewModel.filteredEvents, id: \.id) { event in
                            EventRowView(event: event, viewModel: viewModel)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Events")
                .onAppear {
                    viewModel.fetchData(for: selectedCountry)
                }
                .onChange(of: selectedCountry) { newCountry in
                    viewModel.fetchData(for: newCountry)
                }
            }
        }
    }
}




