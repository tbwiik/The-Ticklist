//
//  NumTriesView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 11/01/2023.
//

import SwiftUI

struct NumTriesView: View {
    
    @Binding var ascent: Tick.Ascent
    
    private var numberOfTriesStr: String {
        String(ascent.numberOfTries) + " Tries"
    }
    
    var body: some View {
        HStack {
            Label(numberOfTriesStr, systemImage: "number")
            Spacer()
            AddButtonView(action: {ascent.incrementTries()})
        }
    }
}

struct NumTries_Previews: PreviewProvider {
    static var previews: some View {
        NumTriesView(ascent: .constant(Tick.sampleAscents[0]))
    }
}
