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
    
    
    
    
    
}

