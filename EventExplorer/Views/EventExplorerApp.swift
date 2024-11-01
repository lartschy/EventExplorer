//
//  EventExplorerApp.swift
//  EventExplorer
//
//  Created by L S on 22/02/2024.
//

import SwiftUI
import SwiftData
import FirebaseCore

@main
 struct EventExplorerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            EventModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

     var body: some Scene {
         WindowGroup {
            MainMenuView(authViewModel: authViewModel)
                .modelContainer(sharedModelContainer)
                .accentColor(.black)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
