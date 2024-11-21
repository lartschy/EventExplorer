//
//  ConcertsCategoryView.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import SwiftUI

// View for displaying concert events by category in the selected country
struct ConcertsCategoryView: View {
    @ObservedObject var viewModel: NearbyEventsViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    
    let types: [String]?
    
    var body: some View {
        EventCategoryView(
            viewModel: viewModel,
            profileViewModel: profileViewModel,
            category: "concert",
            types: types,
            emptyMessage: "No Concert Events Available"
        )
    }
}
