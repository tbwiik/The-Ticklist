//
//  TickView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 05/01/2023.
//

import SwiftUI

struct TickView: View {
    
    @Binding var tick: Tick
    
    var body: some View {
        VStack {
            Text(tick.name)
            Text(tick.date.formatted())
            Text(tick.grade)
        }
    }
}

struct TickView_Previews: PreviewProvider {
    
    static var previews: some View {
        TickView(tick: .constant(Tick.sampleData[0]))
    }
}
