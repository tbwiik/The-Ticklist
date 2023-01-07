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
            Label(tick.grade, systemImage: tick.dicipline.imageString)
            .font(.title2)
            VStack (alignment: .leading){
                Text(tick.name)
                    .font(.headline)
                Text(tick.region)
            }
            .padding()
            Spacer()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(tick: Tick.sampleData.getTick(index: 0)!)
    }
}
