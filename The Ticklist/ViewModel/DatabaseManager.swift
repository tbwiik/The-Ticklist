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


/// User errors
enum UserError: Error{
    case noUser
}

/// Handle communication with firestore database
class DatabaseManager: ObservableObject, DatabaseProtocol {

    /// Define a userID property
    private var user: User?
    
    /// Define a storagePath
    private var storagePath: CollectionReference?
    
    /// Define handler for authentication state
    private var authHandler: AuthStateDidChangeListenerHandle?
    
    
    /// Initializer user handler
    init() {
        addAuthHandler()
    }
    
    /// Add handler for user and authentication state
    func addAuthHandler() {
        if authHandler == nil { // If not already defined
            authHandler = Auth.auth().addStateDidChangeListener({ auth, user in
                self.user = user // Set user
                if let userId = user?.uid { // If user exist, assign path for storage
                    self.storagePath = Firestore.firestore().collection("users").document(userId).collection("TicklistV1")
                }
            })
        }
    }
    
    
    /// Retrieve ticklist from database
    ///  
    /// This function retrieves the whole list asynchronously before populating the ticklist.
    /// An ineffective way to do it, but handling is constrained by the firebase api.
    ///  
    /// - Returns: Ticklist from db
    func fetchTicklist() async throws -> TickList {
        
        var ticklist = TickList()
        
        // Check that user is defined and storagepath is created
        guard let collectionRef = storagePath else {
            throw UserError.noUser
        }
        
        let snapshot = try await collectionRef.getDocuments()
        
        // Go through all ticks in ticklist
        for doc in snapshot.documents {
            let tick = try doc.data(as: Tick.self) // Decode to tick
            ticklist.add(tick) // Add to ticklist
        }
        
        return ticklist
    }
    
    
    /// Saves tick both to db and internal model
    /// - Parameter tick: tick to add
    func saveTick(_ tick: Tick) throws -> Void {
        
        // Check that user is defined and storagepath is created
        guard let collectionRef = storagePath else {
            throw UserError.noUser
        }
        
        // Create tick using internal id
        try collectionRef.document(tick.id.uuidString).setData(from: tick)
    }
    
    
    /// Delete tick from database and model
    ///
    /// - Parameter tick: tick to be deleted
    func deleteTick(_ tick: Tick) async throws -> Void {
        
        guard let collectionRef = storagePath else {
            throw UserError.noUser
        }
        
        try await collectionRef.document(tick.id.uuidString).delete()
    }
    
    
    
}
