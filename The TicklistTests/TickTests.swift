//
//  TickTests.swift
//  The TicklistTests
//
//  Created by Torbjørn Wiik on 11/02/2023.
//

import XCTest
@testable import struct The_Ticklist.Tick

final class TickTests: XCTestCase {
    
    //Considered equal ticks
    var tick1a = Tick(name: "BigRock", region: "Boulder", dicipline: .boulder, grade: "5A", rating: 3, ascents: [], logItems: [])
    var tick1b = Tick(name: "BigRock", region: "Boulder", dicipline: .boulder, grade: "4C", rating: 2, ascents: [], logItems: [])
    
    //Considered a unique tick
    var tick2 = Tick(name: "SmallRock", region: "Boulder", dicipline: .boulder, grade: "5A", rating: 1, ascents: [], logItems: [])

    func testEquals() {
        XCTAssert(tick1a.equals(tickToCompare: tick1b), "Ticks are supposed to be equal")
        XCTAssertFalse(tick1a.equals(tickToCompare: tick2), "Ticks are not supposed to be equal")
    }

}
