//
//  EventView.swift
//  EventExplorer
//
//  Created by L S on 21/05/2024.
//

import SwiftUI

import SwiftUI

import SwiftUI

struct EventView: View {
    let event: EventModel
    @StateObject private var viewModel = NearbyEventsViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(event.name)
                .font(.largeTitle)
                .bold()
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
            Spacer()
        }
        .padding()
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


