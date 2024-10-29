//
//  CategoryItemView.swift
//  EventExplorer
//
//  Created by L S on 29/10/2024.
//

import SwiftUI

// Reusable view for each category item
struct CategoryItemView<Destination: View>: View {
    let title: String
    let imageName: String
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .categoryText(imageName: imageName) // Apply the styling modifier
        }
        .accessibilityLabel(Text("\(title) category")) // Accessibility label for each category
    }
}
