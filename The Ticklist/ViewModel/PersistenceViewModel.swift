//
//  PersistenceViewModel.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 15/11/2023.
//

import Foundation


/// Persistence errors
enum PersistenceError: Error {
    case storageNotInitialized
}

@MainActor

/// Viewmodel handling persistence both for internal model and database
class PersistenceViewModel: ObservableObject {
    
    ///Publishing variable containing ticklist
    @Published var ticklist = TickList()
    
    private var storageInitialized = false
    
    
    /// Manager for handling db actions
    private var dbManager = DatabaseManager()
    
    
    /// Load ticklist from database into internal ticklist
    func loadTickList() async throws -> Void {
        ticklist = try await dbManager.fetchTicklist()
        storageInitialized = true
    }
    
    
    /// Save tick to db and add to internal ticklist
    /// - Warning: Possibly adds tick to internal representation without adding to db. Need aditional testing.
    /// - Parameter tick: tick to add
    func saveTick(_ tick: Tick) throws -> Void {
        
        // Check that the storage is intialized
        guard storageInitialized else {
            throw PersistenceError.storageNotInitialized
        }
        
        try dbManager.saveTick(tick)
        self.ticklist.add(tickToAdd: tick)
    }
    
    
    
    /// Delete tick from db and internal ticklist
    /// - Warning: Possibly removes tick from internal representation without removing from db. Need aditional testing.
    /// - Parameter tick: tick to be deleted
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
