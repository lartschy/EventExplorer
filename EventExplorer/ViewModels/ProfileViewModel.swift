//
//  ProfileViewModel.swift
//  EventExplorer
//
//  Created by L S on 23/09/2024.
//

import Foundation

// ViewModel responsible for managing user profile-related data
class ProfileViewModel: ObservableObject {
    @Published var selectedCountry: String = "Germany" // Default country
    let countries = [
        // List of countries
        "US", "Canada", "Mexico", "Brazil", "Argentina", "Colombia", "Peru", "Chile",
        "United Kingdom", "Germany", "France", "Spain", "Italy", "Netherlands", "Switzerland", "Belgium",
        "Austria", "Sweden", "Norway", "Denmark", "Finland", "Poland", "Greece", "Portugal", "Czech Republic",
        "Ireland", "Hungary", "Romania", "Ukraine", "Slovakia", "Croatia", "Bulgaria", "Lithuania", "Latvia",
        "Estonia", "Slovenia", "Luxembourg", "Malta", "Cyprus"
    ]
}

