//
//  Tick.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 05/01/2023.
//

import Foundation

struct Tick: Identifiable, Codable, Equatable {
    
    let id: UUID
    let name: String
    let region: String
    var dicipline: Dicipline
    var grade: String //Consider changing to own struct later
    var rating: Int
    var logItems: [LogItem]
    
    var isAscents: Bool{
        !logItems.filter{ $0.isTop}.isEmpty
    }
    
    var firstAscent: LogItem?{
        logItems.first(where: {$0.isTop})
    }
    
    init(id: UUID = UUID(), name: String, region: String, dicipline: Dicipline, grade: String, rating: Int, logItems: [LogItem]) {
        self.id = id
        self.name = name
        self.region = region
        self.dicipline = dicipline
        self.grade = grade
        self.rating = rating
        self.logItems = logItems
    }
    
    
    /**
     Compares ticks on name, region and dicipline.
     Case insensitive.
    
     - Parameters:
       - lhs: Tick1
       - rhs: Tick2
     - Returns: True if name, region and dicipline is similar
     **/
    static func ==(lhs: Tick, rhs: Tick) -> Bool {
        let equalNames = lhs.name == rhs.name
        let equalRegions = lhs.region == rhs.region
        let equalDicipline = lhs.dicipline == rhs.dicipline
        return equalNames && equalRegions && equalDicipline
    }
    
}

///Date formatting
extension Date{
    func formatDate() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }
}
