//
//  The_TicklistApp.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 05/01/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct The_TicklistApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var ticklistStore = TickListStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TickListView(ticklist: $ticklistStore.ticklist) {
                    Task {
                        do {
                            try await TickListStore.save(ticklist: ticklistStore.ticklist)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, solution: "Try again")
                        }
                    }
                }
            }
            .task {
                do {
                    ticklistStore.ticklist = try await TickListStore.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, solution: "Loads sample data and continues")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                ticklistStore.ticklist = Tick.sampleData
            }) { wrapped in
                ErrorView(errorWrapper: wrapped)
            }
        }
    }
}
