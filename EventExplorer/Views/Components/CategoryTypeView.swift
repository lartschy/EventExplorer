//
//  CategoryTypeView.swift
//  EventExplorer
//
//  Created by L S on 29/10/2024.
//

import SwiftUICore
import SwiftUI

struct CategoryTypeView<Destination: View>: View {
    // The title displayed in the navigation bar for this view
    let title: String
    
    // Array of categories to display as navigation links
    let categories: [Category]
    
    // Closure that defines the destination view for each category
    let destinationView: (Category) -> Destination

    var body: some View {
        VStack {
            // Vertical stack to arrange category links with spacing
            VStack(spacing: 30) {
                // Loop through each category to create a navigation link
                ForEach(categories, id: \.title) { category in
                    HStack {
                        // Navigation link that navigates to the destination view for the selected category
                        NavigationLink(destination: destinationView(category)) {
                            // Display the category title with associated image
                            Text(category.title)
                                .categoryText(imageName: category.imageName)
                        }
                    }
                }
            }
            .padding([.leading, .trailing], 20) // Horizontal padding for the category links
            .padding(.top, 20) // Top padding for the VStack
            .padding(.bottom, 20) // Bottom padding for the VStack
        }
        .navigationBarBackButtonHidden(true)
    }
    
}
