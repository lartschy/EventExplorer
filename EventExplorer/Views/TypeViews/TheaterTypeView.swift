//
//  TheaterTypeView.swift
//  EventExplorer
//
//  Created by L S on 12/09/2024.
//

import SwiftUI

struct TheaterTypeView: View {
    @StateObject private var viewModel: NearbyEventsViewModel
    @State private var events: [EventModel] = []
    
    init(viewModel: NearbyEventsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
            VStack {
                VStack(spacing: 30) {
                    HStack() {
                        NavigationLink(destination: TheatreCategoryView(viewModel: viewModel, types: ["broadway"])) {
                            Text("Broadway")
                                .categoryText(imageName: "broadway_type")
                        }
                    }
                    
                    HStack() {
                        NavigationLink(destination: TheatreCategoryView(viewModel: viewModel, types: ["comedy"])) {
                            Text("Comedy")
                                .categoryText(imageName: "comedy_type")
                        }
                    }
                    HStack() {
                        NavigationLink(destination: TheatreCategoryView(viewModel: viewModel, types: ["family"])) {
                            Text("Family")
                                .categoryText(imageName: "family_type")
                        }
                    }
                    
                    HStack() {
                        NavigationLink(destination: ConcertsCategoryView(viewModel: viewModel, types: nil)) {
                            Text("All Theater Events")
                                .categoryText(imageName: "all_theater_type")
                        }
                    }
                    
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 20)
                .padding(.bottom, 20)
            }
            .navigationTitle("Theater Events")
            .navigationBarBackButtonHidden(false)
        }
    
    
}
