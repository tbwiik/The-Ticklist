//
//  PersistenceViewModel.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 15/11/2023.
//

import Foundation

@MainActor
class PersistenceViewModel: ObservableObject {
    
    ///Publishing variable containing ticklist
    @Published var ticklist: TickList = TickList()
    
    private var dbManager = DatabaseManager()
    
    init() {
        
        Task{
            ticklist = try await dbManager.fetchTicklist()
            // NOTE: error never handled
        }
    }
    
    func saveTick(_ tick: Tick) throws -> Void {
        try dbManager.saveTick(tick)
        self.ticklist.add(tickToAdd: tick)
    }
    
    func deleteTick(_ tick: Tick) async throws -> Void {
        try await dbManager.deleteTick(tick)
        self.ticklist.remove(tickToRemove: tick)
    }
    
    
}
