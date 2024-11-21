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
   @State private var navigateToEventList = false
   @State private var showAlert = false
   @State private var alertMessage = ""

   // ViewModel handling authentication
   @ObservedObject var authViewModel: AuthViewModel
   
   var body: some View {
       NavigationView {
           ScrollView {
               VStack(spacing: 15) {
                   // App title
                   Text("Event Explorer")
                       .font(.title)
                       .fontWeight(.bold)
                       .padding(.top, 40)
                   
                   Spacer()
                   
                   // Application logo
                   Image("logo")
                       .resizable()
                       .scaledToFit()
                       .frame(maxWidth: 200)
                       .cornerRadius(40)
                   
                   VStack(spacing: 20) {
                       // Subtitle and sign-in prompt
                       Text("Explore the best events!")
                           .font(.title2)
                           .padding(.top, 20)
                       Text("Sign in here:")
                           .padding(.top, -15)
                       
                       // Text field for user email input
                       TextField("Email", text: $email)
                           .padding()
                           .background(Color.gray.opacity(0.3))
                           .cornerRadius(100)
                           .padding(.horizontal)
                       
                       // Secure field for user password input
                       SecureField("Password", text: $password)
                           .padding()
                           .background(Color.gray.opacity(0.3))
                           .cornerRadius(100)
                           .padding(.horizontal)
                       
                       // Sign in button
                       Button(action: {
                           // Calls signIn method from AuthViewModel to authenticate
                           authViewModel.signIn(email: email, password: password) { success in
                               if success {
                                   // If sign-in is successful, navigate to EventListView
                                   navigateToEventList = true
                               } else {
                                   // Display alert with error message on failure
                                   alertMessage = authViewModel.authError?.message ?? "Sign in failed."
                                   showAlert = true
                               }
                           }
                       }) {
                           Text("Sign In")
                       }
                       .buttonStyle(GradientButtonStyle()) // Custom button style
                       
                       // NavigationLink to EventListView, triggers only when navigateToEventList is true
                       NavigationLink(destination: EventListView().navigationBarBackButtonHidden(true), isActive: $navigateToEventList) {
                           EmptyView() // Hidden link to control navigation programmatically
                       }
                       
                       Divider() // Separates sign-in and registration sections
                           .background(Color.black)
                       
                       // Registration prompt and navigation
                       Text("New here? Register an account:")
                       NavigationLink(destination: RegistrationView(authViewModel: authViewModel).navigationBarBackButtonHidden(false)) {
                           Text("Register")
                       }
                       .buttonStyle(GradientButtonStyle()) // Custom button style
                       .padding(.bottom, 10)
                   }
               }
               .alert(isPresented: $showAlert) { // Shows alert if login fails
                   Alert(
                    title: Text("Login Failed"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                   )
               }
               .onReceive(authViewModel.$authError) { error in
                   // Monitors authError from ViewModel; if error is set, display alert
                   if let error = error {
                       alertMessage = error.message
                       showAlert = true
                   }
               }
               .navigationBarHidden(true) // Hides default navigation bar
           }
       }
   }
}
