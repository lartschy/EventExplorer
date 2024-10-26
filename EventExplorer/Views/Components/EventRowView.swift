//
//  EventRowView.swift
//  EventExplorer
//
//  Created by L S on 11/05/2024.
//

import Foundation
import SwiftUI

// The view for a single event in the event list
struct EventRowView: View {
    let event: EventModel
    @ObservedObject var viewModel: NearbyEventsViewModel  // Use @ObservedObject to observe changes in the ViewModel

    @State private var isFavorite: Bool = false

    var body: some View {
        NavigationLink(destination: EventView(event: event)) {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(event.name)
                        .font(.headline)
                        .multilineTextAlignment(.leading)

                    Spacer()

                    Button(action: {
                        // Toggle favorite state in the ViewModel and local state
                        isFavorite.toggle()  // Immediately update local state
                        viewModel.toggleFavourite(for: event.id)  // Update the ViewModel
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.black)
                            .imageScale(.large)
                            .frame(width: 45, height: 45)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                }

                Text(viewModel.formatDate(event.datetimeLocal))
                    .font(.subheadline)
                    .foregroundColor(.white)

                // City information
                HStack {
                    Text("City:")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Text(event.city)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }

                // Country information
                HStack {
                    Text("Country:")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Text(event.country)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }

                // Category information
                HStack {
                    Text("Category:")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Text(event.category)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.6, blue: 0.8), Color(red: 1.0, green: 0.8, blue: 0.6)]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .cornerRadius(10)
            .shadow(radius: 10)
        }
        .onAppear {
            isFavorite = viewModel.isFavourite(eventId: event.id)
        }
    }
}
