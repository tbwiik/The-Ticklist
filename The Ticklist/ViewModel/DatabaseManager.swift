//
//  DatabaseManager.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 14/10/2023.
//
//  Code is written with great inspiration from an official Swift course.

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

@MainActor
/// Handle communication with firestore database
class DatabaseManager: ObservableObject {
    
    ///Publishing variable containing ticklist
    @Published var ticklist: TickList = TickList()
    
    /// Define a userID property
    private var userId: String?
    
    /// Define a storagePath
    private var storagePath: CollectionReference?
    
    /// Define handler for authentication state
    private var authHandler: AuthStateDidChangeListenerHandle?
    
    
    init() {
        addAuthHandler()
    }
    
    /// Add handler for user and authentication state
    func addAuthHandler() {
        if authHandler == nil { // If not already defined
            authHandler = Auth.auth().addStateDidChangeListener({ auth, user in
                self.userId = user != nil ? user!.uid : UUID().uuidString
                self.storagePath = Firestore.firestore().collection("users").document(self.userId!).collection("TicklistV1")
            })
        }
    }
    
    
    func fetchTicklist() async -> Void {
        
        
        guard storagePath != nil else {
            // TODO: wait on authentication handler
        }
        
        do {
            
            let snapshot = try await self.storagePath!.getDocuments()
            let docs = snapshot.documents
            
            for doc in docs {
                let tick = try doc.data(as: Tick.self)
                self.ticklist.add(tickToAdd: tick)
            }
            
        } catch {
            // TODO: handle error
        }
    }
    
    func saveTick(_ tick: Tick) async -> Bool {
        
        guard storagePath != nil else {
            // TODO: wait for authentication handler
        }
        
        do {
            try self.storagePath!.document(tick.id.uuidString).setData(from: tick)
        } catch {
            // TODO: handle failure
        }
        
        return true
    }
    
    func deleteTick() async -> Bool {
        return
    }
    
    
    
}
