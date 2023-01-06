//
//  CardView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 06/01/2023.
//

import SwiftUI

struct CardView: View {
    
    let tick: Tick
    
    var body: some View {
        HStack {
            Label(tick.grade, systemImage: "figure.climbing")
            .font(.title2)
            VStack (alignment: .leading){
                Text(tick.name)
                    .font(.headline)
                Text("Region")
            }
            .padding()
            Spacer()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(tick: Tick.sampleData[1])
    }
}
