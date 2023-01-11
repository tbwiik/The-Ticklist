//
//  AddButtonView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 11/01/2023.
//

import SwiftUI

struct AddButtonView: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: {action()}){
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.green)
        }
    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView(action: {})
    }
}
