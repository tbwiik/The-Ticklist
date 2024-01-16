//
//  MockDatabaseManager.swift
//  The TicklistTests
//
//  Created by Torbjørn Wiik on 24/12/2023.
//

import Foundation
@testable import The_Ticklist

class MockDatabaseManager: DatabaseProtocol{
    
    // Error triggers
    var noUser = false
    var storageNotInit = false
    var noContain = false
    
    // Returns
    var ticklistToReturn = TickList()
    var saveTickCalled = false
    var deleteTickCalled = false

    func fetchTicklist() async throws -> TickList {
        if noUser {
            throw UserError.noUser
        }
        return ticklistToReturn
    }

    func saveTick(_ tick: Tick) throws {
        if noUser {
            throw UserError.noUser
        }
        saveTickCalled = true
    }

    func deleteTick(_ tick: Tick) async throws {
        if noUser {
            throw UserError.noUser
        }
        deleteTickCalled = true
    }
}
