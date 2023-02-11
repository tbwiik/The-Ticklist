//
//  TickListTests.swift
//  The TicklistTests
//
//  Created by Torbjørn Wiik on 10/02/2023.
//

import XCTest
@testable import The_Ticklist

final class TickListTests: XCTestCase {
    
    var tickList: TickList = TickList()
    var tick1 = Tick(name: "", region: "", dicipline: .boulder, grade: "", rating: 0, ascents: [], logItems: [])
    var tick2 = Tick(name: "", region: "", dicipline: .boulder, grade: "", rating: 0, ascents: [], logItems: [])
    var tick3 = Tick(name: "Other", region: "Other", dicipline: .boulder, grade: "", rating: 0, ascents: [], logItems: [])
    
    override func setUpWithError() throws {
        tickList.add(tickToAdd: tick1)
    }

    override func tearDownWithError() throws {
        tickList = TickList()
    }
    
    func testGetTick() {
        XCTAssert(tickList.getTick(index: 0) == tick1, "Does not retrieve correct tick")
        XCTAssertNil(tickList.getTick(index: 1), "Index out of range is supposed to be nil")
    }
    
    func testGetIndex() {
        XCTAssert(tickList.getIndex(tick: tick1) == 0, "Unable to retrieve correct tick")
        XCTAssertNil(tickList.getIndex(tick: tick2), "Tick not in list is supposed to return nil")
    }
    
    func testAdd() {
        
        //Test merging of ticks when equals
        tickList.add(tickToAdd: tick2)
        XCTAssert(tickList.ticks.count == 1)
        
        //Test adding of tick when not equals
        tickList.add(tickToAdd: tick3)
        XCTAssert(tickList.ticks.count == 2)
    }
    
    func testRemove() {
        tickList.remove(tickToRemove: tick1)
        XCTAssert(tickList.ticks.isEmpty, "Failed to remove tick")
    }

}
