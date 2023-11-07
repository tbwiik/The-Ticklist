//
//  AuthFlowView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 28/10/2023.
//

import SwiftUI

struct AuthFlowView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            switch authViewModel.authFlow{
            case .signIn:
                SignInView()
            case .signUp:
                SignUpView()
            }
        }
    }
}

#Preview {
    AuthFlowView().environmentObject(AuthViewModel())
}
