//
//  SportsCategoryView.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import SwiftUI

// View for displaying sports events by category in the selected country
struct SportsCategoryView: View {
    @ObservedObject var viewModel: NearbyEventsViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    
    let types: [String]?
    
    var body: some View {
        EventCategoryView(
            viewModel: viewModel,
            profileViewModel: profileViewModel,
            category: "sports",
            types: types,
            emptyMessage: "No Sport Events Available"
        )
    }
}
