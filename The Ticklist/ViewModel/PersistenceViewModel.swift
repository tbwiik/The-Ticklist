//
//  PersistenceViewModel.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 15/11/2023.
//

import Foundation

enum PersistenceError: Error {
    case storageNotInitialized
}

@MainActor
class PersistenceViewModel: ObservableObject {
    
    ///Publishing variable containing ticklist
    @Published var ticklist = TickList()
    private var storageInitialized = false
    
    private var dbManager = DatabaseManager()
    
    
    func loadTickList() async throws -> Void {
        ticklist = try await dbManager.fetchTicklist()
    }
    
    func saveTick(_ tick: Tick) throws -> Void {
        
        guard storageInitialized else {
            throw PersistenceError.storageNotInitialized
        }
        
        try dbManager.saveTick(tick)
        self.ticklist.add(tickToAdd: tick)
    }
    
    func deleteTick(_ tick: Tick) async throws -> Void {
        
        guard storageInitialized else {
            throw PersistenceError.storageNotInitialized
        }
        
        guard self.ticklist.containsTick(tick) else {
            throw TickListError.notContainsTick
        }
        
        try await dbManager.deleteTick(tick)
        self.ticklist.remove(tickToRemove: tick)
    }
    
    
}
