//
//  The_TicklistApp.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 05/01/2023.
//

import SwiftUI

@main
struct The_TicklistApp: App {
    
    @StateObject private var ticklistStore = TickListStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TickListView(ticklist: $ticklistStore.ticklist) {
                    Task {
                        do {
                            try await TickListStore.save(ticklist: ticklistStore.ticklist)
                        } catch {
                            fatalError("Failed saving")
                        }
                    }
                }
            }
            .task {
                do {
                    ticklistStore.ticklist = try await TickListStore.load()
                } catch {
                    fatalError("Failed loading")
                }
            }
        }
    }
}
