 //
//  MainMenu.swift
//  EventExplorer
//
//  Created by L S on 22/02/2024.
//

import Foundation
import SwiftUI

// Main menu view, where users can log in or navigate to the registration page
struct MainMenuView: View {
    @State private var email: String = "" // User's email input
    @State private var password: String = "" // User's password input
    @State private var navigateToEventList = false // Flag to trigger navigation to the event list
    @State private var showAlert = false // Flag to show login alert
    @State private var alertMessage = "" // Message to display in alert

    @ObservedObject var authViewModel: AuthViewModel // ViewModel for authentication

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Title of the application
                Text("Event Explorer")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 40)

                // Adds space between the title and logo
                Spacer()

                // Application logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(40)
                    .padding(.horizontal)

                VStack(spacing: 20) {
                    // Subtitle and sign-in prompt
                    Text("Explore the best events!")
                        .font(.title2)
                        .padding(.top, 20)
                    Text("Sign in here:")
                        .padding(.top, -15)

                    // Email text field
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(100)
                        .padding(.horizontal)

                    // Password secure field
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(100)
                        .padding(.horizontal)

                    // Sign in button
                    Button(action: {
                        // Call signIn method from authViewModel
                        authViewModel.signIn(email: email, password: password) { success in
                            if success {
                                // Navigate to event list on successful login
                                navigateToEventList = true
                            } else {
                                alertMessage = "Incorrect email or password. Please try again."
                                // Show alert if login fails
                                showAlert = true
                            }
                        }
                    }) {
                        Text("Sign In")
                    }
                    // Apply GradientButtonStyle for the button
                    .buttonStyle(GradientButtonStyle())
                    
                    Divider()
                        .background(Color.black)

                    // Registration prompt
                    Text("New here? Register an account:")
                    NavigationLink(destination: RegistrationView(authViewModel: authViewModel)) {
                        Text("Register")
                    }
                    // Apply GradientButtonStyle for the button
                    .buttonStyle(GradientButtonStyle())
                }
            }
            .alert(isPresented: $showAlert) {
                // Alert configuration for failed login
                Alert(
                    title: Text("Login Failed"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            // Hide navigation bar
            .navigationBarHidden(true)
        }
    }
}
