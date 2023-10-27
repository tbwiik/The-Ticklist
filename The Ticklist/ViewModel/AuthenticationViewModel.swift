//
//  AuthenticationViewModel.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 27/10/2023.
//

import Foundation
import FirebaseAuth

enum AuthState {
    case authenticated
    case unAuthenticated
}

@MainActor
class AuthenticationViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var passwd = ""
    @Published var confirmPasswd = ""
    
    @Published var user: User?
    @Published var authState: AuthState = .unAuthenticated
    
    private var authHandler: AuthStateDidChangeListenerHandle?
    
    init() {
    
        Auth.auth().useEmulator(withHost:"127.0.0.1", port:9099) // Run on emulator and not on production db
    
        addAuthHandler()
    }
    
    func addAuthHandler() {
        
        if authHandler == nil { // If not already defined
            authHandler = Auth.auth().addStateDidChangeListener({ auth, user in
                self.user = user
                self.authState = user == nil ? .unAuthenticated : .authenticated // Set authentication-state on whether user exists
            })
        }
        
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
    
    func deleteUser() async -> Bool {
        
        do {
            try await user?.delete()
            return true
        } catch {
            // TODO: better handle of error
            return false
        }
    }
    
}

