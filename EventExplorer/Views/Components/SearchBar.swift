//
//  SearchBar.swift
//  EventExplorer
//
//  Created by L S on 01/03/2024.
//

import Foundation
import SwiftUI

// The search bar for searching event by specific attributes
struct SearchBar: View {
    // Bindable property for the search text
    @Binding var searchText: String

    var body: some View {
        HStack {
            // Text field for inputting search queries
            TextField("Search", text: $searchText)
                .padding(7)
                .frame(maxWidth: .infinity)  // Makes the text field expand to fill space
                .background(Color(.systemGray6))  // Light gray background for the text field
                .cornerRadius(8)  // Rounded corners for the text field

            // Button to clear the search text (appears only if there's text)
            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
            }
            .opacity(searchText.isEmpty ? 0 : 1)  // Button is hidden if the search field is empty
        }
    }
}

