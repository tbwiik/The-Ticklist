//
//  SheetView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 21/12/2023.
//

import SwiftUI

struct SheetView<Content: View>: View{
    
    var isConfirmEnabled = true
    
    let confirmAction: () -> Void
    let cancelAction: () -> Void
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button("Cancel", role: .cancel, action: {cancelAction()})
                        .padding()
                    Spacer()
                }
                Spacer()
            }
            content()
            VStack{
                Spacer()
                AddButtonView(action: confirmAction, iconSystemName: "checkmark")
                    .disabled(!isConfirmEnabled)
            }
        }
    }
}

#Preview {
    SheetView(confirmAction: {}, cancelAction: {}){
        Image(systemName: "star")
    }
}
