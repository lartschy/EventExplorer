//
//  EventListView.swift
//  EventExplorer
//
//  Created by L S on 22/02/2024.
//

import Foundation
import SwiftUI

struct EventListView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var nearbyEventsViewModel = NearbyEventsViewModel()

    var body: some View {
        NavigationView {
            TabView {
                NearbyEventsView(viewModel: nearbyEventsViewModel)
                    .tabItem {
                        Image(systemName: "location.fill")
                        Text("Nearby")
                    }
                
                SearchEventsView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Browse")
                    }
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
            .tint(.black)
            .navigationBarHidden(true)
        }
    }
}


#Preview {
    EventListView()/*.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)*/
        .modelContainer(for: EventModel.self, inMemory: true)
}

