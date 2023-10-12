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
    }
    
    /**
     Get tick on index.
     
     - Returns: optional tick based on index existing
     */
    func getTick(index: Int) -> Tick? {
        return (ticks.indices.contains(index)) ? ticks[index] : nil
    }
    
    /**
     Add tick or logItem based on whether tick is considered equal
     
     - Add logItem to already created tick of same name and region
     - Add new tick if not already registered
     */
    mutating func add(tickToAdd: Tick) -> Void {
        for tick in ticks {
            if tick == tickToAdd{
                ticks[getIndex(tick: tick)!].logItems.append(contentsOf: tickToAdd.logItems)
                return
            }
        }
        ticks.append(tickToAdd)
        databaseManager.saveTick(tick: tickToAdd) //TODO: remove out of model
    }
    
    ///Remove tick from ticklist
    mutating func remove(tickToRemove: Tick) -> Void {
        ticks.remove(at: getIndex(tick: tickToRemove)!)
    }
}
