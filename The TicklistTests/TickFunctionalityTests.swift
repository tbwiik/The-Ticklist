//
//  TickFunctionalityTests.swift
//  The TicklistTests
//
//  Created by Torbjørn Wiik on 23/12/2023.
//

import XCTest
@testable import The_Ticklist

final class TickFunctionalityTests: XCTestCase {
    
    // Define global
    let id = UUID()
    let nameClimb = "Climb1"
    let region = "Region1"
    let dicipline = Dicipline.sport
    let grade = "5.10"
    let rating = 4
    let logItems: [Tick.LogItem] = []
    
    var tick: Tick! = nil
    

    override func setUpWithError() throws {
        tick = Tick(id: id, name: nameClimb, region: region, dicipline: dicipline, grade: grade, rating: rating, logItems: logItems)

    }

    func testTickInit() {
        
        // Test correct assignments
        XCTAssertEqual(tick.id, id)
        XCTAssertEqual(tick.name, nameClimb)
        XCTAssertEqual(tick.region, region)
        XCTAssertEqual(tick.dicipline, dicipline)
        XCTAssertEqual(tick.grade, grade)
        XCTAssertEqual(tick.rating, rating)
        XCTAssertEqual(tick.logItems, logItems)
    }
    
    func testLogItemInit() {
        
        let logItem = Tick.LogItem()
        
        // Test default values
        XCTAssertEqual(logItem.numberOfTries, 1)
        XCTAssertEqual(logItem.comment, "")
        XCTAssertFalse(logItem.isTop)
    }
    
    func testTickDataInit() {
        
        // Check computed property exist
        XCTAssertNotNil(tick.data)
        
        // Check similar values to tick
        XCTAssertEqual(tick.data.name, tick.name)
        XCTAssertEqual(tick.data.region, tick.region)
        XCTAssertEqual(tick.data.dicipline, tick.dicipline)
        XCTAssertEqual(tick.data.grade, tick.grade)
        XCTAssertEqual(tick.data.rating, tick.rating)
        XCTAssertEqual(tick.data.logItems, tick.logItems)
    }
    
    func testTickDataIsComplete() {
        
        var tickData = Tick.Data()
        
        XCTAssertFalse(tickData.isComplete)
        
        tickData.name = "foo"
        
        XCTAssertFalse(tickData.isComplete)
        
        tickData.region = "bar"

        XCTAssertTrue(tickData.isComplete)
    }
    
    func testIsAcents() {
        let logItemNoTop = Tick.LogItem(isTop: false)
        let logItemTop = Tick.LogItem(isTop: true)
        
        tick.logItems.append(logItemNoTop)
        XCTAssertFalse(tick.isAscents)
        
        tick.logItems.append(logItemTop)
        XCTAssertTrue(tick.isAscents)
    }
    
    func testEqualTicks() {
        
        let tickEqual = Tick(name: nameClimb, region: region, dicipline: dicipline, grade: "notEqual", rating: 1, logItems: [])
        let tickDiffDicipline = Tick(name: nameClimb, region: region, dicipline: Dicipline.boulder, grade: grade, rating: rating, logItems: logItems)
        
        XCTAssertTrue(tick == tickEqual)
        XCTAssertFalse(tick == tickDiffDicipline, "Diff dicipline implies not equal")
    }
    
    func testGetFirstAscent() {
        let logItemNoTop = Tick.LogItem(isTop: false)
        let logItemTop = Tick.LogItem(isTop: true)
        
        tick.logItems.append(logItemNoTop)
        tick.logItems.append(logItemTop)
        
        XCTAssertEqual(tick.firstAscent, logItemTop)
    }


}
