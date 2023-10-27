//
//  AuthenticationViewModel.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 27/10/2023.
//

import Foundation
import FirebaseAuth

@MainActor
class AuthenticationViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var passwd = ""
    @Published var confirmPasswd = ""
    
    init() {
        
        Auth.auth().useEmulator(withHost:"127.0.0.1", port:9099) // Run on emulator and not on production db
        
    }
    
    func signInEmailPasswd() async -> Bool {
        
        do {
            try await Auth.auth().signIn(withEmail: email, password: passwd)
            return true
        } catch {
            // TODO: better handle of error
            return false
        }
    }
    
    func signUpEmailPasswd() async -> Bool {
        
        do {
            try await Auth.auth().createUser(withEmail: email, password: passwd)
            return true
        } catch {
            // TODO: better handle of error
            return false
        }
        
    }
    
    func signOut() async -> Bool {
        
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            // TODO: better handle of error
            return false
        }
        
    }
    
    
}

