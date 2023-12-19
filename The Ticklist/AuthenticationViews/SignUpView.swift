//
//  SignUpView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 27/10/2023.
//

import SwiftUI

// TODO: To a big extent duplicate of SignInView
struct SignUpView: View {
    
    // Get ViewModel responsible for authentication
    @EnvironmentObject var authViewModel: AuthViewModel
    
    // Get environment var that can dismiss views
    @Environment(\.dismiss) private var dismiss
    
    private func signUpEmailPasswd() {
        Task {
            if await authViewModel.signUpEmailPasswd() == true {
//                dismiss()
                // No modal view to remove
            }
        }
    }
    
    var body: some View {
        
        Spacer()
        
        VStack (alignment: .center) {
            
            TextField("Email", text: $authViewModel.email)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            SecureField("Password", text: $authViewModel.passwd)
            SecureField("Confirm password", text: $authViewModel.confirmPasswd)
        }
        .padding(50)
        
        Button (action: signUpEmailPasswd){
            
            if !authViewModel.isAuthenticating(){
                Text("Sign Up")
            } else {
                Text("Authenticating...")
            }
            
        }
        .alert("Sign up failed", isPresented: $authViewModel.isError){
            Button("OK"){
                authViewModel.errorMessage = ""
                authViewModel.reset(.signUp)
            }
        } message: {
            Text(authViewModel.errorMessage)
        }
        
        Spacer()
        
        Button("Sign in", action: authViewModel.switchAuthFlow)
    }
}

#Preview {
    SignUpView().environmentObject(AuthViewModel())
}
