//
//  Tick.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 05/01/2023.
//

import Foundation

struct Tick: Identifiable, Codable {
    
    let id: UUID
    let name: String
    let date: Date
    var grade: String //Consider changing to own struct later
    var rating: Int
    
    init(id: UUID = UUID(), name: String, date: Date, grade: String, rating: Int) {
        self.id = id
        self.name = name
        self.date = date
        self.grade = grade
        self.rating = rating
    }
    
}

extension Tick {
    static let sampleData: [Tick] =
    [
        Tick(name: "Silence", date: Date(), grade: "9c", rating: 5),
        Tick(name: "Burden of Dreams", date: Date(), grade: "9A", rating: 4),
        Tick(name: "Agnesbuen", date: Date(), grade: "9a", rating: 4)
    ]
}
