//
//  AddButtonView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 11/01/2023.
//

import SwiftUI

struct AddButtonView: View {
    
    @Environment(\.isEnabled) var isEnabled
    
    /// Action triggered by button tap
    let action: () -> Void
    
    /// SF symbol systemname for icon on button
    var iconSystemName = "plus"
    
    var body: some View {
        Button(action: {action()}){
            ZStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(isEnabled ? .green : .gray)
                    .font(.system(size: 40))
                Image(systemName: iconSystemName)
                    .foregroundStyle(.white)
                    .font(.system(size: 22))
                    .bold()
            }
        }
    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView(action: {})
    }
}
