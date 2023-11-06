//
//  ProfileView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 06/11/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    private func signOut() {
        Task{
            if await authViewModel.signOut() == true {
                dismiss()
            }
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Authentication actions")) {
                Button {
                    signOut()
                } label: {
                    Text("Sign out")
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
