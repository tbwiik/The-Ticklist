//
//  MockDatabaseManager.swift
//  The TicklistTests
//
//  Created by Torbjørn Wiik on 24/12/2023.
//

import Foundation
@testable import The_Ticklist

class MockDatabaseManager: DatabaseProtocol{
    
    var shouldThrowError = false
    var ticklistToReturn = TickList()
    var saveTickCalled = false
    var deleteTickCalled = false

    func fetchTicklist() async throws -> TickList {
        if shouldThrowError {
            throw PersistenceError.storageNotInitialized
        }
        return ticklistToReturn
    }

    func saveTick(_ tick: Tick) throws {
        if shouldThrowError {
            throw PersistenceError.storageNotInitialized
        }
        saveTickCalled = true
    }

    func deleteTick(_ tick: Tick) async throws {
        if shouldThrowError {
            throw PersistenceError.storageNotInitialized
        }
        deleteTickCalled = true
    }
}
