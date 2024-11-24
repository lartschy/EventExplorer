//
//  EventExplorerApp.swift
//  EventExplorer
//
//  Created by L S on 22/02/2024.
//

import SwiftUI
import FirebaseCore

@main
struct EventExplorerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            MainMenuView(authViewModel: authViewModel)
                .accentColor(.black)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
