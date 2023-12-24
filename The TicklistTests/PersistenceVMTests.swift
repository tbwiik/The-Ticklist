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
    
    let tick = Tick(name: "foo", region: "bar", dicipline: Dicipline.boulder, grade: "4a", rating: 1, logItems: [])
    
    var mockDBManager = MockDatabaseManager()
    var viewModel: PersistenceViewModel! = nil

    override func setUpWithError() throws {
        viewModel = PersistenceViewModel(dbManager: mockDBManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitTickList() {
        XCTAssertTrue(viewModel.ticklist.ticks.isEmpty)
    }

    func testLoadTickListSuccess() async throws {
        
        let expectedTicklist = Tick.sampleData
        
        mockDBManager.ticklistToReturn = expectedTicklist
        try await viewModel.loadTickList()
        
        XCTAssertEqual(viewModel.ticklist, expectedTicklist)
    }
    
    func testLoadTickListThrows() async throws {
        
        mockDBManager.noUser = true
        
        do{
            try await viewModel.loadTickList()
            XCTFail("Loading Ticklist should have thrown error.")
        } catch let error as UserError {
            XCTAssertEqual(error, .noUser)
        } catch {
            XCTFail("Loading Ticklist threw unexpected error.")
        }
    }
    
    func testSaveTickSuccess() async throws {
        
        try await viewModel.loadTickList()
        
        XCTAssertFalse(viewModel.ticklist.containsTick(tick))
        try viewModel.saveTick(tick)
        XCTAssertTrue(mockDBManager.saveTickCalled)
        XCTAssertTrue(viewModel.ticklist.containsTick(tick))
        
    }
    
    func testSaveTickTrows() async throws {
        
        do {
            try viewModel.saveTick(tick)
            XCTFail("Saving should fail when storage is not init.")
        } catch let error as PersistenceError {
            XCTAssertEqual(error, .storageNotInitialized)
        } catch {
            XCTFail("Saving Tick threw unexpected error.")
        }
        
        XCTAssertFalse(mockDBManager.saveTickCalled)
    }
    
    func testDeleteTickSuccess() async throws {
        
        try await viewModel.loadTickList()
        viewModel.ticklist.ticks.append(tick)
        
        try await viewModel.deleteTick(tick)
        XCTAssertTrue(mockDBManager.deleteTickCalled)
        XCTAssertFalse(viewModel.ticklist.containsTick(tick))
    }
    
    func testDeleteTickThrows() async throws {
        
        // Test failure when storage is not initialized
        do{
            try await viewModel.deleteTick(tick)
            XCTFail("Deletion should fail when storage is not init.")
        } catch let error as PersistenceError {
            XCTAssertEqual(error, .storageNotInitialized)
        } catch {
            XCTFail("Deleting Tick threw unexpected error.")
        }
        
        XCTAssertFalse(mockDBManager.deleteTickCalled)
        
        // Initialize storage
        try await viewModel.loadTickList()
        
        // Test failure when Ticklist doesn't contain given tick
        do{
            try await viewModel.deleteTick(tick)
            XCTFail("Deletion should fail when Tick is not in list.")
        } catch let error as TickListError {
            XCTAssertEqual(error, .notContainsTick)
        } catch {
            XCTFail("Deleting Tick threw unexpected error.")
        }
        XCTAssertFalse(mockDBManager.deleteTickCalled)
        
    }
}
