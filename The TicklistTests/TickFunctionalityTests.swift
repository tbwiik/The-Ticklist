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
    let logItems = [Tick.LogItem()] // Assuming LogItem has an initializer
    
    var tick: Tick! = nil
    

    override func setUpWithError() throws {
        tick = Tick(id: id, name: nameClimb, region: region, dicipline: dicipline, grade: grade, rating: rating, logItems: logItems)

    }

//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

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


}
