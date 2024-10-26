//
//  ConcertsTypeView.swift
//  EventExplorer
//
//  Created by L S on 12/09/2024.
//

import SwiftUI

struct ConcertsTypeView: View {
    @StateObject private var viewModel: NearbyEventsViewModel
    @ObservedObject var profileViewModel: ProfileViewModel


    init(viewModel: NearbyEventsViewModel, profileViewModel: ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.profileViewModel = profileViewModel
    }
    
    var body: some View {
            VStack {
                VStack(spacing: 30) {
                    HStack() {
                        NavigationLink(destination: ConcertsCategoryView(viewModel: viewModel, profileViewModel: profileViewModel, types: ["festival"])) {
                            Text("Festival")
                                .categoryText(imageName: "festival_type")
                        }
                    }
                    
                    HStack() {
                        NavigationLink(destination: ConcertsCategoryView(viewModel: viewModel, profileViewModel: profileViewModel, types: ["classical"])) {
                            Text("Classical")
                                .categoryText(imageName: "classical_type")
                        }
                    }
                    HStack() {
                        NavigationLink(destination: ConcertsCategoryView(viewModel: viewModel, profileViewModel: profileViewModel, types: ["pop"])) {
                            Text("Pop")
                                .categoryText(imageName: "pop_type")
                        }
                    }
                    
                    HStack() {
                        NavigationLink(destination: ConcertsCategoryView(viewModel: viewModel, profileViewModel: profileViewModel, types: nil)) {
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
