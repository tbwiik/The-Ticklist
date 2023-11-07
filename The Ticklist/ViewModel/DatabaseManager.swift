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

/*
 Manager for saving and loading to remote FireStore database.
 */
class DatabaseManager: ObservableObject {
    
    ///Publishing variable containing ticklist
    @Published var ticklist: TickList = TickList()
    
    /// Define a userID property
    private var userId: String?
    
    /**
     Define default storage path for a ticklist in database.
     
     This path will in theory never be used due to overwrite in initializer
     */
    private var storagePath: CollectionReference {
        
        /* WARNING:
         Due to addStateDidChangeListener is running asynchronously
         may it be possible for the next line of code to enter else even with user
         That is both incorrect, and will also result in lost data...
         */
         
        if self.userId != nil{
            return Firestore.firestore().collection("users").document(self.userId!).collection("TicklistV1")
        } else {
            return Firestore.firestore().collection("tmp-ticklist")
        }
        
    }
    
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
            })
        }
        
    }
    
    
    /**
     Asynchronously load data from db
     
     - Throws error if failing to load
     */
    func load() async throws -> TickList {
        try await withCheckedThrowingContinuation{ continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let ticklist):
                    continuation.resume(returning: ticklist)
                }
            }
        }
    }
    
    /**
     Load ticklist from db
     
     - If successfull: completion with data
     - If failure: completion with error
     */
    func load(completion: @escaping (Result<TickList, Error>) -> Void){
        
        // Is it bad running this whole piece on main thread? Probably
        // Does it work? Fuck yes
        
        DispatchQueue.main.async{
            
            self.storagePath.getDocuments { snapshot, error in
                
                // Check no error
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                // Check that snapshot exists
                guard snapshot != nil else {
                    let error = NoSnapShotError.noSnapShotError("Failed to retrieve collection-snapshot from Firestore.")
                    completion(.failure(error))
                    return
                }
                
                // Go through all documents and add to ticklist
                for doc in snapshot!.documents{

                    do{
                        let tick = try doc.data(as: Tick.self)
                        self.ticklist.add(tickToAdd: tick)
                    } catch {
                        completion(.failure(error))
                    }

                }
                
                // Return successfull result
                completion(.success(self.ticklist))
                
            }
            
        }
        
    }
    
    /**
     Asynchronously save data to db
     
     - Throws error if failing to save
     */
    @discardableResult
    func save() async throws -> Int {
        try await withCheckedThrowingContinuation{ continuation in
            save(){ result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let ticklistSaved):
                    continuation.resume(returning: ticklistSaved)
                }
            }
        }
    }
    
    /**
     Save ticklist to db
     
     - If successfull: completion with count of ticks added
     - If failure: completion with error
     */
    func save(completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                // Save ticklist to database
                for tick in self.ticklist.ticks {
                    try self.storagePath.document(tick.id.uuidString).setData(from: tick)
                }
                
                // Return successfull completion with number of ticks added
                DispatchQueue.main.async {
                    // TODO: change/remove line under?
                    completion(.success(self.ticklist.ticks.count))
                }
                
            // Handle error if occurs
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }
    }
}


enum NoSnapShotError: Error {
    case noSnapShotError(String)
}

