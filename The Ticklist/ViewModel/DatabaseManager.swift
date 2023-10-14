//
//  DatabaseManager.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 12/10/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabaseManager: ObservableObject {
    
    //TODO: updates UI and must therefore be run on main thread
    //TODO: error handling
        
    let db = Firestore.firestore()


    ///Publishing variable containing ticklist
    @Published var ticklist: TickList = TickList()
    
//    init() {
//        loadTickList()
//    }
    

    static func loadTickList() -> TickList {

        // Specify vars
        let list = Firestore.firestore().collection("newTestList")
        var res = TickList()

        list.getDocuments { snapshot, error in

            guard error != nil && snapshot != nil else {
                // TODO: Handle error
                return
            }

            // get docs
            for doc in snapshot!.documents{
                
                do{
                    let tick = try doc.data(as: Tick.self)
                    res.add(tickToAdd: tick)
                } catch {
                    // TODO: handle error
                    print()
                }
                
            }
                    
        }
        
        return res
        
    }
    
    static func saveTickList(ticklist: TickList) throws -> Void {
        
        let coll = Firestore.firestore().collection("newTestList")
        
        for tick in ticklist.ticks {
            try coll.document(tick.id.uuidString).setData(from: tick)
        }
        
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
    
    static func removeTick(tick: Tick) -> Void {
        
        let coll = Firestore.firestore().collection("newTestList")
        
        coll.document(tick.id.uuidString).delete()

    }
}

enum ConversionError: Error {
        case conversionFail
}
