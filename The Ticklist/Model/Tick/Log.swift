//
//  Log.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 11/01/2023.
//

import Foundation

///Used for logging tries
extension Tick {
    
    struct LogItem: Identifiable, Codable, Equatable{
        let id: UUID
        let date: Date
        var numberOfTries: Int
        var comment: String
        var isTop: Bool
        
        init(id: UUID = UUID(), date: Date, numberOfTries: Int, comment: String, isTop: Bool) {
            self.id = id
            self.date = date
            self.numberOfTries = numberOfTries
            self.comment = comment
            self.isTop = isTop
        }
    }
}
