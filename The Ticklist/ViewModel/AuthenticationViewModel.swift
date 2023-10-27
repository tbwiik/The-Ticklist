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
    case authenticating
    case unAuthenticated
}

enum AuthError: LocalizedError{
    case emptyConfirmPassword
    case noMatchConfirmPassword
    
    var errorDescription: String? {
        switch self {
        case .emptyConfirmPassword:
            return NSLocalizedString("The field \"Confirm Password\" cannot be emtpy", comment: "Confirm Password is empty")
        case .noMatchConfirmPassword:
            return NSLocalizedString("The field \"Confirm password\" doesn't match \"Password\" ", comment: "NonMatching \"Confirm Password\"")
        }
    }
}

@MainActor
class AuthenticationViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var passwd = ""
    @Published var confirmPasswd = ""
    
    @Published var user: User?
    @Published var authState: AuthState = .unAuthenticated
    
    // Define error Wrapper
    @Published var errorWrapper: ErrorWrapper?
    
    private var authHandler: AuthStateDidChangeListenerHandle?
    
    init() {
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
    
    func reset() {
        self.authState = .unAuthenticated
        self.email = ""
        self.passwd = ""
        self.confirmPasswd = ""
    }
    
    func signInEmailPasswd() async -> Bool {
        
        authState = .authenticating
        
        do {
            try await Auth.auth().signIn(withEmail: email, password: passwd)
            return true
        } catch {
            errorWrapper = ErrorWrapper(error: error, solution: "Try to Sign In again")
            authState = .unAuthenticated
            return false
        }
    }
    
    func signUpEmailPasswd() async -> Bool {
        
        authState = .authenticating
        
        do {
            
            guard !confirmPasswd.isEmpty else {
                throw AuthError.emptyConfirmPassword
            }
            
            guard confirmPasswd == passwd else {
                throw AuthError.noMatchConfirmPassword
            }
            
            try await Auth.auth().createUser(withEmail: email, password: passwd)
            return true
        } catch {
            errorWrapper = ErrorWrapper(error: error, solution: "Try to Sign Up again")
            authState = .unAuthenticated
            return false
        }
        
    }
    
    func signOut() async -> Bool {
        
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            errorWrapper = ErrorWrapper(error: error, solution: "Try to Sign out again")
            return false
        }
        
    }
    
    func deleteUser() async -> Bool {
        
        do {
            try await user?.delete()
            return true
        } catch {
            errorWrapper = ErrorWrapper(error: error, solution: "Try to Delete User again")
            return false
        }
    }
    
}

