//
//  EventView.swift
//  EventExplorer
//
//  Created by L S on 21/05/2024.
//

import SwiftUI
import MapKit

// The detailed view for a single event
struct EventView: View {
    // The event being displayed
    let event: EventModel
    
    // ViewModel for fetching and formatting event data
    @StateObject private var viewModel = NearbyEventsViewModel()

    // Computes the map region centered on the event's latitude and longitude
    private var mapRegion: MKCoordinateRegion {
        
        // Convert the event's lat/lon strings to Double values; default to 0 if conversion fails
        let latitude = Double(event.lat) ?? 0.0
        let longitude = Double(event.lon) ?? 0.0

        // Create a region centered on the event's coordinates with a defined span (zoom level)
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)  // Span determines the zoom level
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Event name in large, bold font
            Text(event.name)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.leading)

            // Display event category in a smaller font
            Text("Category: \(event.category)")
                .font(.title2)
                .foregroundColor(.gray)

            // Event type information
            Text("Type: \(event.type)")
                .font(.title3)

            // Venue information
            Text("Venue: \(event.venue)")
                .font(.title3)

            // Address information
            Text("Address: \(event.address)")
                .font(.title3)

            // City information
            Text("City: \(event.city)")
                .font(.title3)

            // Country information
            Text("Country: \(event.country)")
                .font(.title3)

            // Display the event date and time formatted by the ViewModel
            Text("Date and Time: \(viewModel.formatDate(event.datetimeLocal))")
                .font(.title3)
                .foregroundColor(.gray)

            // Map view showing the event's location
            Map(coordinateRegion: .constant(mapRegion), annotationItems: [event]) { event in
                // Places a red pin at the event's location
                MapPin(coordinate: CLLocationCoordinate2D(latitude: Double(event.lat) ?? 0.0, longitude: Double(event.lon) ?? 0.0), tint: .red)
            }
            .frame(height: 200)  // Defines the height for the map

            Spacer()  // Pushes the button to the bottom

            // Button to view the event on its official website
            Button(action: {
                if let url = URL(string: event.url) {  // Safely unwrap the event URL
                    UIApplication.shared.open(url)  // Open the event's URL in a browser
                }
            }) {
                // Button label
                Text("View on Website")
            }
            .buttonStyle(GradientButtonStyle()) // Apply GradientButtonStyle for the button
            .padding(.top, 20)  // Adds top padding to space the button from other content
        }
        .padding()  // Adds padding around the entire VStack
        .navigationTitle("Event Details")  // Sets the title for the navigation bar
        .navigationBarTitleDisplayMode(.inline)  // Displays the title inline, without large font
    }
}
