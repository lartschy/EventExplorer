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
    // State variables to control alerts and navigation
    @State private var showingAlert = false
    @State private var navigateToMainMenu = false

    // User input fields for registration details
    @ObservedObject var authViewModel: AuthViewModel
    @State private var passwordAgain: String = ""

    var body: some View {
        // Navigation view for the registration screen
        NavigationView {
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("Email address")
                        .font(.headline)
                    TextField("Email", text: $authViewModel.email)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(100)
                        .padding(.horizontal)
                }

                VStack(spacing: 10) {
                    Text("Password")
                        .font(.headline)
                    SecureField("Password", text: $authViewModel.password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(100)
                        .padding(.horizontal)
                }

                VStack(spacing: 10) {
                    Text("Password Again")
                        .font(.headline)
                    SecureField("Password Again", text: $passwordAgain)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(100)
                        .padding(.horizontal)
                }
                
                Spacer()

                Button(action: {
                    authViewModel.register()
        
                    // Check registration success and show alert
                    if authViewModel.registrationSuccess {
                        showingAlert = true
                    }
                }) {
                    Text("Register")
                        .gradientButtonStyle()
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Success"),
                        message: Text("Registration Successful!"),
                        dismissButton: .default(Text("OK"), action: {
                            navigateToMainMenu = true // Navigate back on dismiss
                        })
                    )
                }
                
                // Navigation Link for MainMenuView
                NavigationLink(destination: MainMenuView(authViewModel: authViewModel).navigationBarBackButtonHidden(true), isActive: $navigateToMainMenu) {
                    EmptyView()
                }
                .navigationTitle("Registration") // Title of the registration screen
            }
            // Listen for changes to registration success and show alert
            .onReceive(authViewModel.$registrationSuccess) { success in
                if success {
                    showingAlert = true
                }
            }
        }
    }
}
