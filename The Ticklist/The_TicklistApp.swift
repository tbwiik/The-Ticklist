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
    
    // Define error state
    @State private var isError = false
    @State private var errorMessage = ""
    
    // Define Tab state
    @State private var selectedTab = 1
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                AuthStateView {
                    TabView(selection: $selectedTab){
                        TickListView()
                            .tabItem{
                                Label("Home", systemImage: "house")
                            }
                            .tag(1)
                        ProfileView()
                            .tabItem{
                                Label("Account", systemImage: "person.crop.circle.fill")
                            }
                            .tag(2)
                    }
                    .task { // Load remote ticklist into local before view appears
                        do {
                            try await persistenceViewModel.loadTickList()
                        } catch {
                            errorMessage = error.localizedDescription
                            isError = true
                        }
                    }
                    .alert("Failed to load data", isPresented: $isError){
                        Button("OK", role: .cancel){
                            errorMessage = ""
                        }
                    } message: {
                        Text(errorMessage)
                    }
                }
                .environmentObject(authViewModel)
                .environmentObject(persistenceViewModel)
            }
        }
    }
}
