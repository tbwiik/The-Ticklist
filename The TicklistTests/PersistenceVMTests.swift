//
//  PersistenceVMTests.swift
//  The TicklistTests
//
//  Created by Torbjørn Wiik on 24/12/2023.
//

import XCTest
@testable import The_Ticklist

@MainActor
final class PersistenceVMTests: XCTestCase {
    
    var mockDBManager = MockDatabaseManager()
    var viewModel: PersistenceViewModel! = nil

    override func setUpWithError() throws {
        viewModel = PersistenceViewModel(dbManager: mockDBManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadTickListSuccess() async throws {
        
    }
    
    func testLoadTickListError() async throws {
        
        mockDBManager.shouldThrowError = true
        
        do{
            try await viewModel.loadTickList()
            XCTFail("Loading Ticklist should have thrown error")
        } catch let error as PersistenceError {
            XCTAssertEqual(error, .storageNotInitialized)
        } catch {
            XCTFail("Loading Ticklist threw unexpected error")
        }
    }
    
    

}
