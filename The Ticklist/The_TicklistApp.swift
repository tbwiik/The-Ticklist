//
//  The_TicklistApp.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 05/01/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

// Configure database
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
    FirebaseApp.configure()
    Auth.auth().useEmulator(withHost:"127.0.0.1", port:9099) // Run on emulator and not on production db
      
    // This code connect the simulator to a local Firebase emulator and not production db
    // Remember to $firebase emulators:start before use
    let settings = Firestore.firestore().settings;
    settings.host = "127.0.0.1:8080";
    //        settings.cacheSettings = false;
    settings.isSSLEnabled = false;
    Firestore.firestore().settings = settings;
      
    return true
  }
}

@main
struct The_TicklistApp: App {
    
    // Initialize database
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // Initialize Environment-objects
    @StateObject private var persistenceViewModel = PersistenceViewModel()
    @StateObject var authViewModel = AuthViewModel()
    
    // Define errorWrapper
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                AuthStateView {
                    TickListView()
                    .task {
                        do {
                            try await persistenceViewModel.loadTickList()
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, solution: "Intialize empty Ticklist")
                        }
                    }
                }
                .environmentObject(authViewModel)
                .environmentObject(persistenceViewModel)
            }
            
            // Display errormessage
            .sheet(item: $errorWrapper, onDismiss: {
                persistenceViewModel.ticklist = TickList()
            }) { wrapped in
                ErrorView(errorWrapper: wrapped)
            }
        }
    }
}
