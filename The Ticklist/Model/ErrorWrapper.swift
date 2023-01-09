//
//  ErrorWrapper.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 06/01/2023.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let solution: String

    init(id: UUID = UUID(), error: Error, solution: String) {
        self.id = id
        self.error = error
        self.solution = solution
    }
}
