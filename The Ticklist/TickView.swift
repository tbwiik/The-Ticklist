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
        List {
            Section(header: Text("Info")){
                HStack {
                    Text(tick.name + ",")
                        .font(.headline)
                    Text(tick.region)
                }
                Label(tick.grade, systemImage: tick.dicipline.imageString)
                Label(tick.dateString, systemImage: "calendar")
                Label(String(tick.rating), systemImage: "star")
            }
        }
    }
}

extension Tick {
    var dateString: String {
        DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
    }
}

struct TickView_Previews: PreviewProvider {
    
    static var previews: some View {
        TickView(tick: .constant(Tick.sampleData[0]))
    }
}
