//
//  TickListView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 05/01/2023.
//

import SwiftUI

struct TickListView: View {
    
    @Binding var ticklist: [Tick]
    
    var body: some View {
        List {
            ForEach(ticklist) { tick in
                NavigationLink(destination: {}){
                    Text(tick.name)
                }
            }
        }
        .navigationTitle("Ticklist")
    }
}

struct TickListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TickListView(ticklist: .constant(Tick.sampleData))
        }
    }
}
