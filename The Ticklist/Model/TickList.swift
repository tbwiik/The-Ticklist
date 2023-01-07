//
//  TickList.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 07/01/2023.
//

import Foundation

struct TickList: Identifiable, Codable {
    
    let id: UUID
    var name: String
    var ticks: [Tick]
    
    init(id: UUID = UUID(), name: String = "New Ticklist", ticks: [Tick] = []) {
        self.id = id
        self.name = name
        self.ticks = ticks
    }
    
    func getIndex(tick: Tick) -> Int? {
        ticks.firstIndex(where: {$0 == tick})
        //HERE
    }
    
    func getTick(index: Int) -> Tick? {
        ticks[index]
    }
    
    /**
     Add tick or ascent based on whether tick is considered equal
     
     - Add ascents to already created tick of same name and region
     - Add new tick if not already registered
     */
    mutating func add(tickToAdd: Tick) -> Void {
        for tick in ticks {
            if tick.equals(tickToCompare: tickToAdd){
                ticks[getIndex(tick: tick)!].ascents.append(contentsOf: tickToAdd.ascents)
                return
            }
        }
        ticks.append(tickToAdd)
    }
    
    ///Remove tick from ticklist
    mutating func remove(tickToRemove: Tick) -> Void {
        ticks.remove(at: getIndex(tick: tickToRemove)!)
    }
}
