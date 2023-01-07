//
//  Dicipline.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 07/01/2023.
//

import Foundation
import SwiftUI

///Climbing diciplines
enum Dicipline: String, CaseIterable, Identifiable, Codable {
    
    case boulder
    case sport
    case trad
    case ice
    
    ///returns string for respective SF Symbol
    var imageString: String{
        switch self {
        case .boulder:
            return "triangle"
        case .sport:
            return "figure.climbing"
        case .trad:
            return "mountain.2"
        case .ice:
            return "ice"
        }
    }
    
    ///Returns capitalized name
    var name: String {
        rawValue.capitalized
    }
    
    /**
     Define id for conforming to identifiable
     
     NB! Changing to another type will result in pickers breaking (need explicit tags)
     */
    var id: Self { self }
}
