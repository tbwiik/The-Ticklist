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
    let date: Date
    var grade: String //Consider changing to own struct later
    var rating: Int
    
    init(id: UUID = UUID(), name: String, region: String, date: Date, grade: String, rating: Int) {
        self.id = id
        self.name = name
        self.region = region
        self.date = date
        self.grade = grade
        self.rating = rating
    }
    
}

extension Tick {
    
    /**
     Temporary data struct for storing tick information
     */
    struct Data {
        var name: String = ""
        var region: String = ""
        var date: Date = Date()
        var grade: String = ""
        var rating: Double = 0.0
    }
    
    ///Create data object
    var data: Data {
        Data(name: name, region: region, date: date, grade: grade, rating: Double(rating))
    }
    
    ///Initialize new Tick with data information
    init(data: Tick.Data) {
        id = UUID()
        name = data.name
        region = data.region
        date = data.date
        grade = data.grade
        rating = Int(data.rating)
    }
}

extension Tick {
    static let sampleData: [Tick] =
    [
        Tick(name: "Silence", region: "Hanshelleren", date: Date(), grade: "9c", rating: 5),
        Tick(name: "Burden of Dreams", region: "Finland", date: Date(), grade: "9A", rating: 4),
        Tick(name: "Agnesbuen", region: "Østlandet", date: Date(), grade: "9a", rating: 4)
    ]
}
