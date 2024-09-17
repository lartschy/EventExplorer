//
//  ConcertsTypeView.swift
//  EventExplorer
//
//  Created by L S on 12/09/2024.
//

import SwiftUI

struct ConcertsTypeView: View {
    @StateObject private var viewModel: NearbyEventsViewModel
    @State private var events: [EventModel] = []
    
    init(viewModel: NearbyEventsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
            VStack {
                VStack(spacing: 30) {
                    HStack() {
                        NavigationLink(destination: ConcertsCategoryView(viewModel: viewModel, types: ["festival"])) {
                            Text("Festival")
                                .categoryText(imageName: "festival_type")
                        }
                    }
                    
                    HStack() {
                        NavigationLink(destination: ConcertsCategoryView(viewModel: viewModel, types: ["classical"])) {
                            Text("Classical")
                                .categoryText(imageName: "classical_type")
                        }
                    }
                    HStack() {
                        NavigationLink(destination: ConcertsCategoryView(viewModel: viewModel, types: ["pop"])) {
                            Text("Pop")
                                .categoryText(imageName: "pop_type")
                        }
                    }
                    
                    HStack() {
                        NavigationLink(destination: ConcertsCategoryView(viewModel: viewModel, types: nil)) {
                            Text("All Concerts")
                                .categoryText(imageName: "all_concerts_type")
                        }
                    }
                    
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 20)
                .padding(.bottom, 20)
            }
            .navigationTitle("Concert Events")
            .navigationBarBackButtonHidden(false)
        }
    
    
}
