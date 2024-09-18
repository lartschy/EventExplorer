//
//  EventView.swift
//  EventExplorer
//
//  Created by L S on 21/05/2024.
//

import SwiftUI
import MapKit

struct EventView: View {
    let event: EventModel
    @StateObject private var viewModel = NearbyEventsViewModel()
    
    private var mapRegion: MKCoordinateRegion {
           let latitude = Double(event.lat) ?? 0.0
           let longitude = Double(event.lon) ?? 0.0
           
           return MKCoordinateRegion(
               center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
               span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
           )
    }    

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(event.name)
                .font(.largeTitle)
                .bold()
                .lineLimit(nil) // Allow unlimited lines
                .multilineTextAlignment(.leading) // Align text to the leading edge
            Text("Category: \(event.category)")
                .font(.title2)
                .foregroundColor(.gray)
            Text("Type: \(event.type)")
                .font(.title3)
            Text("Venue: \(event.venue)")
                .font(.title3)
            Text("Address: \(event.address)")
                .font(.title3)
            Text("City: \(event.city)")
                .font(.title3)
            Text("Country: \(event.country)")
                .font(.title3)
            Text("Date and Time: \(viewModel.formatDate(event.datetimeLocal))")
                .font(.title3)
                .foregroundColor(.gray)
            
            // Map view
            Map(coordinateRegion: .constant(mapRegion), annotationItems: [event]) { event in
                MapPin(coordinate: CLLocationCoordinate2D(latitude: Double(event.lat) ?? 0.0, longitude: Double(event.lon) ?? 0.0), tint: .red)
            }
            .frame(height: 200) // Set a fixed height for the map view
            
            
            Spacer()

            Button(action: {
                if let url = URL(string: event.url) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("View on Website")
            }
            .gradientButtonStyle()
            .padding(.top, 20)
        }
        .padding()
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


