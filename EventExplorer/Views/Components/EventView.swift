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

    // State to show the action sheet
    @State private var showingActionSheet = false

    // Computes the map region centered on the event's latitude and longitude
    private var mapRegion: MKCoordinateRegion {
        // Convert the event's lat/lon strings to Double values; default to 0 if conversion fails
        let latitude = Double(event.lat) ?? 0.0
        let longitude = Double(event.lon) ?? 0.0

        // Create a region centered on the event's coordinates with a defined span (zoom level)
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }

    // Helper function to open the address in the selected map app
    private func openInMapApp(_ app: String) {
        let address = event.address.replacingOccurrences(of: " ", with: "+")
        let query = "\(event.venue), \(event.city), \(event.country)"
        
        let urlString: String
        switch app {
        case "Apple Maps":
            urlString = "http://maps.apple.com/?q=\(query)"
        case "Google Maps":
            urlString = "comgooglemaps://?q=\(query)"
        default:
            return
        }

        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if app == "Google Maps" {
            // Fallback to Google Maps website if the app is not installed
            if let webURL = URL(string: "https://www.google.com/maps/search/?api=1&query=\(address)") {
                UIApplication.shared.open(webURL)
            }
        }
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

            // Address information with clickable text
            HStack {
                Text("Address:")
                    .font(.title3)
                Button(action: {
                    showingActionSheet = true
                }) {
                    Text(event.address)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .underline()
                }
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text("Open Address"),
                    message: Text("Choose an app to open the address in:"),
                    buttons: [
                        .default(Text("Apple Maps")) { openInMapApp("Apple Maps") },
                        .default(Text("Google Maps")) { openInMapApp("Google Maps") },
                        .cancel()
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
            Map(coordinateRegion: .constant(mapRegion), annotationItems: [event]) { event in
                MapPin(coordinate: CLLocationCoordinate2D(latitude: Double(event.lat) ?? 0.0, longitude: Double(event.lon) ?? 0.0), tint: .red)
            }
            .frame(height: 200)

            Spacer()

            // Button to view the event on its official website
            Button(action: {
                if let url = URL(string: event.url) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("View on Website")
            }
            .buttonStyle(GradientButtonStyle())
            .padding(.top, 20)
        }
        .padding()
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
