//
//  CountryModel.swift
//  EventExplorer
//
//  Created by L S on 23/09/2024.
//

import Foundation

// Model for the country selected by the user
class CountryModel: ObservableObject {
    @Published var selectedCountry: String = "Germany"
}
