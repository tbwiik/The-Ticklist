//
//  DatabaseProtocol.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 24/12/2023.
//

import Foundation

protocol DatabaseProtocol {
    func fetchTicklist() async throws -> TickList
    func saveTick(_ tick: Tick) throws
    func deleteTick(_ tick: Tick) async throws
}
