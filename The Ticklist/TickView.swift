//
//  TickView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 05/01/2023.
//

import SwiftUI

struct TickView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @Binding var tick: Tick
    
    let saveAction: ()->Void
    
    var body: some View {
        List {
            Section(header: Text("Info")){
                HStack {
                    Text(tick.name + ",")
                        .font(.headline)
                    Text(tick.region)
                }
                Label(tick.grade, systemImage: tick.dicipline.imageString)
                Label(tick.ascents[0].date.formatDate(), systemImage: "calendar.badge.exclamationmark")
                Label(String(tick.rating), systemImage: "star")
            }
            Section(header: Text("Ascents")){
                ForEach(tick.ascents){ ascent in
                    Label(ascent.date.formatDate(), systemImage: "bolt")
                }
                .onDelete{ indexSet in
                    tick.ascents.remove(atOffsets: indexSet)
                }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {saveAction()}
        }
    }
}

struct TickView_Previews: PreviewProvider {
    
    static var previews: some View {
        TickView(tick: .constant(Tick.sampleData.getTick(index: 0)!), saveAction: {})
    }
}
