//
//  EventRowView.swift
//  EventExplorer
//
//  Created by L S on 11/05/2024.
//

import Foundation
import SwiftUI

struct EventRowView: View {
    let event: EventModel
    let viewModel: NearbyEventsViewModel

    var body: some View {
        NavigationLink(destination: EventView(event: event)) {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(event.name)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Text(viewModel.formatDate(event.datetimeLocal))
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                HStack {
                    Text("City:")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Text(event.city)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
                HStack {
                    Text("Country:")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Text(event.country)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
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
    }
}


