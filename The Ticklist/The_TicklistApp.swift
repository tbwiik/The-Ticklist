//
//  The_TicklistApp.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 05/01/2023.
//

import SwiftUI

@main
struct The_TicklistApp: App {
    
    @State private var ticklist = Tick.sampleData
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TickListView(ticklist: $ticklist)
            }
        }
    }
}
