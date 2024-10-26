//
//  ProfileView.swift
//  EventExplorer
//
//  Created by L S on 01/03/2024.
//

import Foundation
import SwiftUI

// Profile view for the user's data, customizations, and actions
struct ProfileView: View {
    // Controls whether the logout alert is shown
    @State private var showAlert = false
    
    // Controls navigation to main menu
    @State private var navigateToMainMenu = false
    
    // View model for managing country selection
    @ObservedObject var profileViewModel: ProfileViewModel
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            // Page title
            Text("User Profile")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 40) // Adds top padding for spacing
            
            // Country selection label
            Text("Select your country:")
                .font(.headline)
                .padding(.top, 20)
            
            // Country selector (e.g., a Picker)
            Picker("Select Country", selection: $profileViewModel.selectedCountry) {
                ForEach(profileViewModel.countries, id: \.self) { country in
                    Text(country).tag(country)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            Spacer() // Pushes the logout button to the bottom
            
            logoutButton // Custom logout button view
            
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            // Shows a confirmation alert for logging out
            Alert(
                title: Text("Logout"),
                message: Text("Are you sure you want to logout?"),
                primaryButton: .cancel(), // Cancel button
                secondaryButton: .destructive(Text("Logout"), action: {
                    // If logout is confirmed, set navigation flag to true
                    authViewModel.logout() // Call your logout method
                    navigateToMainMenu = true
                })
            )
        }
        
        // Navigates to main menu when the user confirms logout
        .background(
            NavigationLink(destination: MainMenuView(authViewModel: authViewModel), isActive: $navigateToMainMenu) {
                EmptyView()
            }
        )
    }

    // Custom button for logging out
    private var logoutButton: some View {
        Button(action: {
            showAlert = true // Shows the logout confirmation alert
        }) {
            Text("Logout")
                .font(.title3)
                .frame(maxWidth: .some(150)) // Sets a fixed width for the button
                .padding()
                .foregroundColor(.white)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 1.0, green: 0.6, blue: 0.8),
                            Color(red: 1.0, green: 0.8, blue: 0.6)
                        ]),
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing
                    )
                )
                .cornerRadius(100) // Rounded corners for the button
                .padding(.horizontal)
        }
    }
}

