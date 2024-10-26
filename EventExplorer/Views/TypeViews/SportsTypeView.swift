//
//  SportsTypeView.swift
//  EventExplorer
//
//  Created by L S on 12/09/2024.
//

import SwiftUI

struct SportsTypeView: View {
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
                        NavigationLink(destination: SportsCategoryView(viewModel: viewModel, profileViewModel: profileViewModel, types: ["basketball", "mlb", "wnba"]) ) {
                            Text("Basketball")
                                .categoryText(imageName: "basketball_type")
                        }
                    }
                    
                    HStack() {
                        NavigationLink(destination: SportsCategoryView(viewModel: viewModel, profileViewModel: profileViewModel, types: ["soccer", "mls", "ncaa_soccer"])) {
                            Text("Soccer")
                                .categoryText(imageName: "soccer_type")
                        }
                    }
                    HStack() {
                        NavigationLink(destination: SportsCategoryView(viewModel: viewModel, profileViewModel: profileViewModel, types: ["nfl", "football"])) {
                            Text("American Football")
                                .categoryText(imageName: "football_type")
                        }
                    }
                    
                    HStack() {
                        NavigationLink(destination: SportsCategoryView(viewModel: viewModel, profileViewModel: profileViewModel, types: nil)) {
                            Text("All Sports")
                                .categoryText(imageName: "all_sports_type")
                        }
                    }
                    /*
                    HStack() {
                        NavigationLink(destination: SportsCategoryView(viewModel: viewModel, types: ["baseball", "minor_league_baseball"])) {
                            Text("Baseball")
                                .categoryText(imageName: "baseball_type")
                        }
                    }
                    
                    HStack() {
                        NavigationLink(destination: SportsCategoryView(viewModel: viewModel, types: ["volleyball", "college_volleyball"])) {
                            Text("Volleyball")
                                .categoryText(imageName: "volleyball_type")
                        }
                    }
                    HStack() {
                        NavigationLink(destination: SportsCategoryView(viewModel: viewModel, types: ["hockey"])) {
                            Text("Hockey")
                                .categoryText(imageName: "hockey_type")
                        }
                    }
                    HStack() {
                        NavigationLink(destination: SportsCategoryView(viewModel: viewModel, types: ["stadium_tours"])) {
                            Text("Stadium tours")
                                .categoryText(imageName: "stadiumtour_type")
                        }
                    }
                    */
                    
                    
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 20)
                .padding(.bottom, 20)
            }
            .navigationTitle("Sport Events")
            .navigationBarBackButtonHidden(false)
        }
}
