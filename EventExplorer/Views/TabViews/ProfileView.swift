//
//  ProfileView.swift
//  EventExplorer
//
//  Created by L S on 01/03/2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @State private var showAlert = false
    @State private var navigateToMainMenu = false

    var body: some View {
        VStack {
            Text("User Profile")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 40)

            logoutButton
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Logout"),
                message: Text("Are you sure you want to logout?"),
                primaryButton: .default(Text("Cancel")),
                secondaryButton: .destructive(Text("Logout"), action: {
                    navigateToMainMenu = true
                })
            )
        }
        .background(
            NavigationLink(
                destination: MainMenuView().navigationBarHidden(true),
                isActive: $navigateToMainMenu
            ) {
                EmptyView()
            }
        )
    }

    private var logoutButton: some View {
        Button(action: {
            showAlert = true
        }) {
            Text("Logout")
                .font(.title3)
                .frame(maxWidth: .some(150))
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
                .cornerRadius(100)
                .padding(.horizontal)
        }
    }
}


#Preview {
    ProfileView()/*.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)*/
}
