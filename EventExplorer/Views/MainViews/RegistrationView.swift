//
//  RegistrationView.swift
//  EventExplorer
//
//  Created by L S on 22/02/2024.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
    @State private var showingAlert = false    
    @State private var navigateToMainMenu = false

    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordAgain: String = ""

    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                
                    
                    VStack(spacing: 10) {
                        Text("Username")
                            .font(.headline)
                        TextField("Username", text: $username)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(100)
                            .padding(.horizontal)
                    }
                    VStack(spacing: 10) {
                        Text("Email address")
                            .font(.headline)
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(100)
                            .padding(.horizontal)
                    }

                    
                   
                
                Divider()
                    .background(Color.black)
                
                
                    VStack(spacing: 10) {
                        Text("Password")
                            .font(.headline)
                        TextField("Password", text: $password)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(100)
                            .padding(.horizontal)
                    }
                    VStack(spacing: 10) {
                        Text("Password Again")
                            .font(.headline)
                        TextField("Password Again", text: $passwordAgain)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(100)
                            .padding(.horizontal)
                    }
                
              
                Divider()
                    .background(Color.black)
                
                
                NavigationLink(destination: MainMenuView()) {
                    Button(action: {
                        showingAlert = true
                    }) {
                        Text("Register")
                            
                            .gradientButtonStyle()
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Success"),
                            message: Text("Successful Registration"),
                            dismissButton: .default(Text("OK"), action: {
                                navigateToMainMenu = true
                            })
                        )
                    }
                    .background()
                }

                .navigationTitle("Registration")
            }
            
        }
        
    }
}


#Preview {
    RegistrationView()/*.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)*/
}

