//
//  AuthStateView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 28/10/2023.
//

import SwiftUI

struct AuthStateView<Content>: View where Content: View{
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @ViewBuilder var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        
        VStack{
            switch authViewModel.authState {
            case .authenticated:
                content()
            case .authenticating:
                Text("Waiting for authentication...")
            case .unAuthenticated:
                AuthFlowView()
            }
        }
    }
}

#Preview {
    AuthStateView{
        Text("Placeholder")
    }
}
