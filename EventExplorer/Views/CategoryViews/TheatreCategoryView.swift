//
//  TheatreCategoryView.swift
//  EventExplorer
//
//  Created by L S on 19/05/2024.
//

import SwiftUI

// View for displaying theatre events by category in the selected country
struct TheatreCategoryView: View {
    @ObservedObject var viewModel: NearbyEventsViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    
    let types: [String]?
    
    var body: some View {
        EventCategoryView(
            viewModel: viewModel,
            profileViewModel: profileViewModel,
            category: "theater",
            types: types,
            emptyMessage: "No Theatre Events Available"
        )
    }
}
