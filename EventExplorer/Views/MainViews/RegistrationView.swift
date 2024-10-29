//
//  RegistrationView.swift
//  EventExplorer
//
//  Created by L S on 22/02/2024.
//

import Foundation
import SwiftUI

// Registration view for new users to create an account
struct RegistrationView: View {
    // Observable view model handling authentication logic and data binding
    @ObservedObject var authViewModel: AuthViewModel
    
    // State variable to control alert presentation
    @State private var showingAlert = false
    
    // State variable to store alert messages (error or success messages)
    @State private var alertMessage = ""
    
    // State variable to handle navigation to MainMenuView
    @State private var navigateToMainMenu = false

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                // Email input field
                VStack(spacing: 10) {
                    Text("Email address")
                        .font(.headline)
                    TextField("Email", text: $authViewModel.email)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(100)
                        .padding(.horizontal)
                }

                // Password input field
                VStack(spacing: 10) {
                    Text("Password")
                        .font(.headline)
                    SecureField("Password", text: $authViewModel.password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(100)
                        .padding(.horizontal)
                }

                // Password confirmation input field
                VStack(spacing: 10) {
                    Text("Password Again")
                        .font(.headline)
                    SecureField("Password Again", text: $authViewModel.passwordAgain) // Using passwordAgain directly from the view model
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(100)
                        .padding(.horizontal)
                }

                Spacer() // Spacer to create some space before the register button

                // Register button
                Button(action: {
                    authViewModel.register() // Calls register function in AuthViewModel
                }) {
                    Text("Register")
                }
                .buttonStyle(GradientButtonStyle())
                
                // Alert for displaying success or error messages
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text(authViewModel.registrationSuccess ? "Success" : "Registration Error"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"), action: {
                            if authViewModel.registrationSuccess {
                                navigateToMainMenu = true // Navigate to MainMenuView on success
                            }
                        })
                    )
                }

                // Navigation link to MainMenuView
                NavigationLink(destination: MainMenuView(authViewModel: authViewModel).navigationBarBackButtonHidden(true), isActive: $navigateToMainMenu) {
                    EmptyView() // Empty view to hold the navigation link
                }
                .navigationTitle("Registration") // Title for the navigation bar
            }
            
            // Listen for changes in authError to display an error alert
            .onChange(of: authViewModel.authError) { error in
                if let error = error {
                    alertMessage = error.message // Set the alert message with error details
                    showingAlert = true // Show alert for error
                }
            }
            
            // Listen for changes in registrationSuccess to display a success alert
            .onChange(of: authViewModel.registrationSuccess) { success in
                if success {
                    alertMessage = "Registration Successful!" // Set success message
                    showingAlert = true // Show success alert
                }
            }
        }
    }
}
