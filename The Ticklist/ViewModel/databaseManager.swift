//
//  databaseManager.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 12/10/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class databaseManager: ObservableObject {
    
    //TODO: updates UI and must therefore be run on main thread
    //TODO: error handling
        
    let db = Firestore.firestore()


    ///Publishing variable containing ticklist
    @Published var ticklist: TickList = TickList()
    
    init() {
        getTicklist()
    }
    
    // TODO: write code to spin up fromr remote database
    func getTicklist() -> Void {
        return
    }
    
    static func saveTick(tick: Tick) -> Void {
        
        let coll = Firestore.firestore().collection("newTestList")
        
        do{
            try coll.document(tick.id.uuidString).setData(from: tick)
        } catch {
            // TODO: handle error
            return
        }
    }
}
