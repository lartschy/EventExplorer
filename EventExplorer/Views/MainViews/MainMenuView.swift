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
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isRegistrationActive: Bool = false
    @State private var navigateToEventList = false

    @ObservedObject var authViewModel: AuthViewModel

    enum NavigationItem {
        case eventList, registration
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Event Explorer")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 40)

                Spacer()

                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(40)
                    .padding(.horizontal)

                VStack(spacing: 20) {
                    Text("Explore the best events!")
                        .font(.title2)
                        .padding(.top, 20)
                    Text("Sign in here:")
                        .padding(.top, -15)

                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(100)
                        .padding(.horizontal)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(100)
                        .padding(.horizontal)

                    Button(action: {
                        // Call signIn method from authViewModel
                        authViewModel.signIn(email: email, password: password) { success in
                            if success {
                                navigateToEventList = true // Set navigation variable to true
                            }
                        }
                    }) {
                        Text("Sign In")
                            .gradientButtonStyle() // Custom button style
                    }

                    // Navigation Link for EventListView
                    NavigationLink(destination: EventListView().navigationBarBackButtonHidden(true), isActive: $navigateToEventList) {
                        EmptyView() // Hidden link
                    }

                    Divider()
                        .background(Color.black)

                    Text("New here? Register an account:")
                    NavigationLink(destination: RegistrationView(authViewModel: authViewModel).navigationBarBackButtonHidden(true)) {
                        Text("Register")
                            .gradientButtonStyle() // Custom button style
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}
