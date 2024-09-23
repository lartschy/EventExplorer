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
    
    // The event model containing event details
    let event: EventModel
    
    // ViewModel to access necessary data and functionality
    let viewModel: NearbyEventsViewModel
    
    // State to track whether the event is marked as favorite
    @State private var isFavorite: Bool = false

    var body: some View {
        // Navigation link that takes the user to the EventView when tapped
        NavigationLink(destination: EventView(event: event)) {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    // Displays the event name in bold and allows multiline
                    Text(event.name)
                        .font(.headline)
                        .multilineTextAlignment(.leading)

                    Spacer()  // Spacer to push the heart icon to the right side

                    // Button to mark/unmark the event as favorite
                    Button(action: {
                        isFavorite.toggle()  // Toggles the favorite state
                    }) {
                        // Display a filled heart if the event is a favorite, else show an outline
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .black : .black)  // Keeps heart icon black for both states
                            .imageScale(.large)  // Scales the image to large
                            .frame(width: 45, height: 45)  // Sets a fixed size for the button
                            .background(Color.white)  // White background for the heart button
                            .clipShape(Circle())  // Rounds the button into a circle
                            .shadow(radius: 10)  // Adds a shadow effect for the button
                    }
                }

                // Display formatted date and time for the event
                Text(viewModel.formatDate(event.datetimeLocal))
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)

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
            .padding()  // Adds padding around the VStack
            .frame(maxWidth: .infinity)  // Ensures the VStack expands to the full available width

            // Background with a gradient from pink to light peach colors
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.6, blue: 0.8), Color(red: 1.0, green: 0.8, blue: 0.6)]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .cornerRadius(10)  // Rounds the corners of the event cell
            .shadow(radius: 10)  // Adds a shadow for a floating effect
        }
    }
}


