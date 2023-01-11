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
        var date: Date
        var numberOfTries: Int
        var comment: String
        var isTop: Bool
        
        //TODO solve differently? E.g. Tick.Data≈
        init(id: UUID = UUID(), date: Date = Date(), numberOfTries: Int = 1, comment: String = "", isTop: Bool = false) {
            self.id = id
            self.date = date
            self.numberOfTries = numberOfTries
            self.comment = comment
            self.isTop = isTop
        }
    }
}
