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

    // State to show the action sheet for map selection
    @State private var showingActionSheet = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // Event name in large, bold font
                Text(event.name)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineLimit(2) // Limit the text to two lines
                    .minimumScaleFactor(0.8) // Shrink text if necessary

                // Display event category in a smaller font
                Text("Category: \(event.category)")
                    .font(.title2)
                    .foregroundColor(.gray)

                // Event type information, formatted via the ViewModel
                Text("Type: \(viewModel.formatType(event.type))")
                    .font(.title3)

                // Venue information
                Text("Venue: \(event.venue)")
                    .font(.title3)

                // Address information with clickable text
                HStack {
                    Text("Address:")
                        .font(.title3)
                    Button(action: {
                        // Show an action sheet to select a map app
                        showingActionSheet = true
                    }) {
                        Text(event.address)
                            .font(.title3)
                            .foregroundColor(.blue)
                            .underline()
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                }
                .actionSheet(isPresented: $showingActionSheet) {
                    // Action sheet to let the user choose a map app
                    ActionSheet(
                        title: Text("Open Address"),
                        message: Text("Choose an app to open the address in:"),
                        buttons: [
                            // Open address in Apple Maps
                            .default(Text("Apple Maps")) {
                                viewModel.openAddressInMap(for: event, app: "Apple Maps")
                            },
                            // Open address in Google Maps
                            .default(Text("Google Maps")) {
                                viewModel.openAddressInMap(for: event, app: "Google Maps")
                            },
                            .cancel() // Cancel button
                        ]
                    )
                }

                // City and Country information
                Text("City: \(event.city)")
                    .font(.title3)
                Text("Country: \(event.country)")
                    .font(.title3)

                // Display the event date and time formatted by the ViewModel
                Text("Date and Time: \(viewModel.formatDate(event.datetimeLocal))")
                    .font(.title3)
                    .foregroundColor(.gray)

                // Map view showing the event's location
                Map(
                    // Use the ViewModel to compute the map region for the event
                    coordinateRegion: .constant(viewModel.computeMapRegion(for: event)),
                    annotationItems: [event]
                ) { event in
                    // Place a pin at the event's location
                    MapPin(
                        coordinate: CLLocationCoordinate2D(
                            latitude: Double(event.lat) ?? 0.0,
                            longitude: Double(event.lon) ?? 0.0
                        ),
                        tint: .red
                    )
                }
                .frame(height: UIScreen.main.bounds.height > 700 ? 200 : 150) // Adjust map height for smaller screens

                Spacer()

                // Button to view the event on its official website
                Button(action: {
                    // Open the event's website in the default browser
                    if let url = URL(string: event.url) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("View on Website")
                }
                .buttonStyle(GradientButtonStyle()) // Custom button style
                .padding(.top, 20)
                .padding(.bottom, 10)
            }
            .padding()
            .navigationTitle("Event Details") // Navigation title
            .navigationBarTitleDisplayMode(.inline) // Compact title style
        }
    }
}
