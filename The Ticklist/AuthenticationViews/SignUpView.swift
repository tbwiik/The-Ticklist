//
//  SignUpView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 27/10/2023.
//

import SwiftUI

struct SignUpView: View {
    
    // Get ViewModel responsible for authentication
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    // Get environment var that can dismiss views
    @Environment(\.dismiss) private var dismiss
    
    private func signUpEmailPasswd() {
        Task {
            if await authViewModel.signUpEmailPasswd() == true {
                dismiss()
            }
        }
    }
    
    var body: some View {
        
        VStack (alignment: .center) {
            
            TextField("Email", text: $authViewModel.email)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            SecureField("Password", text: $authViewModel.passwd)
            SecureField("Confirm password", text: $authViewModel.confirmPasswd)
        }
        .padding()
        
        Button (action: signUpEmailPasswd){
            
            if !authViewModel.isAuthenticating(){
                Text("Sign Up")
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
    SignUpView().environmentObject(AuthenticationViewModel())
}
