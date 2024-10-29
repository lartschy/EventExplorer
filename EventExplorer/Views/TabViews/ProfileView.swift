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
    
    // Controls navigation to the main menu after logout
    @State private var navigateToMainMenu = false

    // ViewModel for managing country selection and other profile-related settings
    @ObservedObject var profileViewModel: ProfileViewModel
    
    // ViewModel for handling user authentication, including login and logout functions
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            // Page title
            Text("User Profile")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 40)
                .accessibilityAddTraits(.isHeader) // Accessibility header for page title
                
            // Country selection label
            Text("Select your country:")
                .font(.headline)
                .padding(.top, 20)
                .accessibilityLabel(Text("Select your country"))
            
            // Country selector (e.g., a Picker)
            Picker("Select Country", selection: $profileViewModel.selectedCountry) {
                ForEach(profileViewModel.countries, id: \.self) { country in
                    Text(country).tag(country)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .accessibilityLabel(Text("Country Picker"))
            
            Spacer() // Pushes the logout button to the bottom
            
            // Logout button using the custom GradientButtonStyle
            Button(action: { showAlert = true }) {
                Text("Logout")
                    .accessibilityLabel(Text("Logout Button"))
            }
            .buttonStyle(GradientButtonStyle()) // Apply custom button style
            
        }
        .alert(isPresented: $showAlert) {
            // Shows a confirmation alert for logging out
            Alert(
                title: Text("Logout"),
                message: Text("Are you sure you want to logout?"),
                primaryButton: .cancel(),
                secondaryButton: .destructive(Text("Logout"), action: {
                    authViewModel.logout() // Call the logout method in the authentication ViewModel
                    navigateToMainMenu = true
                })
            )
        }
        
        // Navigates to main menu when the user confirms logout
        .background(
            NavigationLink(destination: MainMenuView(authViewModel: authViewModel).navigationBarBackButtonHidden(true), isActive: $navigateToMainMenu) {
                EmptyView()
            }
        )
    }
}
