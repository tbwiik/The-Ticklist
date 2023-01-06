//
//  TickListStore.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 06/01/2023.
//

import Foundation

/// Observable storage of ticklist
class TickListStore: ObservableObject {
    
    ///Publishing variable containing ticklist
    @Published var ticklist: [Tick] = []
    
    /**
     Provide a file-url for storage file in the documentdirectory
     Stored in "ticklist.data"
     
     - Returns: fileURL to storage file
     */
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("ticklist.data")
    }

    
    /**
     Asynchronously load data from file
     
     - Throws error of failing to load
     */
    static func load() async throws -> [Tick] {
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
     Load ticklist from file
     
     - If successfull: completion with data
     - If unsuccesfull: completion with empty array
     - If failure: completion with error
     */
    static func load(completion: @escaping (Result<[Tick], Error>) -> Void){
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let ticklist = try JSONDecoder().decode([Tick].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(ticklist))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    /**
     Asynchronously save data to file
     
     - Throws error if failing to save
     */
    @discardableResult
    static func save(ticklist: [Tick]) async throws -> Int {
        try await withCheckedThrowingContinuation{ continuation in
            save(ticklist: ticklist){ result in
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
     Save ticklist to file
     
     - If successfull: completion with data
     - If unsuccesfull: completion with empty array
     - If failure: completion with error
     */
    static func save(ticklist: [Tick], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(ticklist)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(ticklist.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
