//
//  sampleData.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 11/01/2023.
//

import Foundation

extension Tick {
    
    static let sampleLogItem = LogItem(date: Date(), numberOfTries: 6, comment: "Lessgoo", isTop: true)
    
    static let sampleLogItems: [LogItem] = [
        LogItem(date: Date(), numberOfTries: 2, comment: "Got halfway up", isTop: false),
        LogItem(date: Date(), numberOfTries: 4, comment: "2 Links left", isTop: false),
        sampleLogItem
    ]
    
    /// Ticklist sample containing 3 different Ticks
    static let sampleData: TickList = TickList(ticks:
    [
        Tick(name: "Silence", region: "Hanshelleren", dicipline: .sport, grade: "9c", rating: 5, logItems: sampleLogItems),
        Tick(name: "Burden of Dreams", region: "Finland", dicipline: .boulder, grade: "9A", rating: 4, logItems: sampleLogItems),
        Tick(name: "Agnesbuen", region: "Østlandet", dicipline: .sport, grade: "9a", rating: 4, logItems: sampleLogItems)
    ])
}
