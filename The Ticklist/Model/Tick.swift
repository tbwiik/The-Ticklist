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
    var ascents: [Ascent]
    
    init(id: UUID = UUID(), name: String, region: String, dicipline: Dicipline, grade: String, rating: Int, ascents: [Ascent]) {
        self.id = id
        self.name = name
        self.region = region
        self.dicipline = dicipline
        self.grade = grade
        self.rating = rating
        self.ascents = ascents
    }
    
    /**
     Compares on name and region

     - Compares values directly
     - CaseSensitive
     */
    func equals(tickToCompare:Tick) -> Bool {
        let equalNames = name == tickToCompare.name
        let equalRegions = region == tickToCompare.region
        return equalNames && equalRegions
    }
    
}

extension Tick {
    
    /**
     Temporary data struct for storing tick information
     */
    struct Data {
        var name: String = ""
        var region: String = ""
        var dicipline: Dicipline = Dicipline.boulder
        var grade: String = ""
        var rating: Int = 0
        var ascents: [Ascent] = [Ascent(date: Date(), numberOfTries: 1)]
        
        /**
         Is considered complete if there is a name and region
         
         Date is always assigned a value and can therefore be ignored
        */
        var isComplete: Bool {
            !name.isEmpty && !region.isEmpty
        }
    }
    
    ///Create data object
    var data: Data {
        Data(name: name, region: region, dicipline: dicipline, grade: grade, rating: rating, ascents: ascents)
    }
    
    ///Initialize new Tick with data information
    init(data: Tick.Data) {
        id = UUID()
        name = data.name
        region = data.region
        dicipline = data.dicipline
        grade = data.grade
        rating = data.rating
        ascents = data.ascents
    }
}

extension Tick {
    
    ///Ascent of climb
    struct Ascent: Identifiable, Codable, Equatable {
        let id: UUID
        var date: Date
        var numberOfTries: Int
        
        init(id: UUID = UUID(), date: Date, numberOfTries: Int) {
            self.id = id
            self.date = date
            self.numberOfTries = numberOfTries
        }
    }
}

extension Date{
    func formatDate() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }
}

extension Tick {
    
    static let sampleAscents: [Ascent] = [
        Ascent(date: Date(), numberOfTries: 3),
        Ascent(date: Date(), numberOfTries: 7),
        Ascent(date: Date(), numberOfTries: 2)
    ]
    
    static let sampleData: TickList = TickList(ticks:
    [
        Tick(name: "Silence", region: "Hanshelleren", dicipline: .sport, grade: "9c", rating: 5, ascents: sampleAscents),
        Tick(name: "Burden of Dreams", region: "Finland", dicipline: .boulder, grade: "9A", rating: 4, ascents: sampleAscents),
        Tick(name: "Agnesbuen", region: "Østlandet", dicipline: .sport, grade: "9a", rating: 4, ascents: sampleAscents)
    ])
}
