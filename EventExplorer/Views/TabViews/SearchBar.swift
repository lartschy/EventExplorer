//
//  SearchBar.swift
//  EventExplorer
//
//  Created by L S on 01/03/2024.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(7)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
            }
            .opacity(searchText.isEmpty ? 0 : 1)
        }
    }
}
