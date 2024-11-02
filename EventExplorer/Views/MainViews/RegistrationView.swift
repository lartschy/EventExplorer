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
    @ObservedObject var authViewModel: AuthViewModel
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var navigateToMainMenu = false
    
    var body: some View {
        NavigationView {
            // Allows the view to be scrollable
            ScrollView {
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
                        SecureField("Password Again", text: $authViewModel.passwordAgain)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(100)
                            .padding(.horizontal)
                    }

                    Spacer() // Space to adjust layout
                    
                    // Register button
                    Button(action: {
                        authViewModel.register()
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
                                    navigateToMainMenu = true
                                }
                            })
                        )
                    }

                    // Navigation link to MainMenuView
                    NavigationLink(destination: MainMenuView(authViewModel: authViewModel).navigationBarBackButtonHidden(true), isActive: $navigateToMainMenu) {
                        EmptyView()
                    }
                }
                .padding()
            }
            .onChange(of: authViewModel.authError) { error in
                if let error = error {
                    alertMessage = error.message
                    showingAlert = true
                }
            }
            .onChange(of: authViewModel.registrationSuccess) { success in
                if success {
                    alertMessage = "Registration Successful!"
                    showingAlert = true
                }
            }
            .navigationTitle("Registration")
        }
    }
}
