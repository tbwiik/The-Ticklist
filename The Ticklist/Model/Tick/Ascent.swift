//
//  Ascent.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 11/01/2023.
//

import Foundation

///Ascent (top) extension for Ticking
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
        
        mutating func incrementTries() -> Void {
            numberOfTries += 1
        }
    }
}
