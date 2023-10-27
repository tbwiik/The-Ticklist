//
//  SignInView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 27/10/2023.
//

import SwiftUI

// TODO: To a big extent duplicate of SignUpView
struct SignInView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    // Get environment var that can dismiss views
    @Environment(\.dismiss) private var dismiss
    
    private func signInEmailPasswd() {
        Task {
            if await authViewModel.signInEmailPasswd() == true {
                dismiss()
            }
        }
    }
    
    var body: some View {
        
        VStack {
            TextField("Email", text: $authViewModel.email)
            SecureField("Password", text: $authViewModel.passwd)
        }
        .padding()
        
        Button (action: signInEmailPasswd){
            
            if !authViewModel.isAuthenticating(){
                Text("Sign In")
            } else {
                Text("Authenticating...")
            }
            
        }
        .sheet(item: $authViewModel.errorWrapper, onDismiss: {
            authViewModel.reset()
        }) { wrapped in
            ErrorView(errorWrapper: wrapped)
        }
    }
}

#Preview {
    SignInView()
}
