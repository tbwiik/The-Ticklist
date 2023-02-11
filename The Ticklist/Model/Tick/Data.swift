//
//  Data.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 11/01/2023.
//

import Foundation

///Preassigned temporary data for Ticking
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
        var logItems: [LogItem] = [LogItem(date: Date(), numberOfTries: 1, comment: "", isTop: false)]
        
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
        Data(name: name, region: region, dicipline: dicipline, grade: grade, rating: rating, logItems: logItems)
    }
    
    ///Initialize new Tick with data information
    init(data: Tick.Data) {
        id = UUID()
        name = data.name
        region = data.region
        dicipline = data.dicipline
        grade = data.grade
        rating = data.rating
        logItems = data.logItems
    }
}
