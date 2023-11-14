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

enum UserError: Error{
    case noUser
}

/// Handle communication with firestore database
class DatabaseManager: ObservableObject {
    
    ///Publishing variable containing ticklist
    @Published var ticklist: TickList = TickList()
    
    /// Define a userID property
    private var user: User?
    
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
                self.user = user
                if let userId = user?.uid {
                    Firestore.firestore().collection("users").document(userId).collection("TicklistV1")
                }
            })
        }
    }
    
    
    func fetchTicklist() async throws -> TickList {
        
        var ticklist = TickList()
        
        guard let collectionRef = storagePath else {
            throw UserError.noUser
        }
        
        let snapshot = try await collectionRef.getDocuments()
        for doc in snapshot.documents {
            let tick = try doc.data(as: Tick.self)
            ticklist.add(tickToAdd: tick)
        }
        
        return ticklist
    }
    
    func saveTick(_ tick: Tick) throws -> Void {
        
        guard let collectionRef = storagePath else {
            throw UserError.noUser
        }
        
        try collectionRef.document(tick.id.uuidString).setData(from: tick)
    }
    
    func deleteTick(_ tick: Tick) async throws -> Void {
        
        guard let collectionRef = storagePath else {
            throw UserError.noUser
        }
        
        try await collectionRef.document(tick.id.uuidString).delete()
    }
    
    
    
}
