//
//  SearchEventsView.swift
//  EventExplorer
//
//  Created by L S on 01/03/2024.
//

import Foundation
import SwiftUI

struct SearchEventsView: View {
    @State private var searchText = ""
    @State private var events: [EventModel] = []
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        NavigationLink(destination: SportsCategoryView(viewModel: NearbyEventsViewModel())) {
                            Text("Sports")
                                .categoryText(imageName: "sports_category")
                        }
                        NavigationLink(destination: ConcertsCategoryView(viewModel: NearbyEventsViewModel())) {
                            Text("Concerts")
                                .categoryText(imageName: "music_category")
                        }
                        
                    }
                    HStack(spacing: 20) {
                        NavigationLink(destination: TheatreCategoryView(viewModel: NearbyEventsViewModel())) {
                            Text("Theatre")
                                .categoryText(imageName: "theatre_category")
                        }
                        
                    }
                    
                }
                .padding([.leading, .trailing], 20)
                .padding(.bottom, 30)
            }
            .navigationTitle("Browse Events")
            .navigationBarBackButtonHidden(true)
        }
    }
}
