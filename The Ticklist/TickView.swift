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
    @State var newLogItem = Tick.LogItem()
    @State var isLogging = false
    
    let saveAction: ()->Void
    
    var body: some View {
        ZStack {
            List {
                Section(header: Text("Info")){
                    HStack {
                        Text(tick.name)
                            .font(.headline)
                        Text(tick.region)
                    }
                    .accessibilityElement(children: .combine)
                    Label(tick.grade, systemImage: tick.dicipline.imageString)
                    Label(tick.ascents[0].date.formatDate(), systemImage: "calendar.badge.exclamationmark")
                    NumTriesView(ascent: $tick.ascents[0])
                    StarRating(rating: $tick.rating)
                }
                Section(header: Text("Ascents")){
                    ForEach(tick.ascents){ ascent in
                        Label(ascent.date.formatDate(), systemImage: "bolt")
                            .deleteDisabled(ascent == tick.ascents[0])
                    }
                    .onDelete{ indexSet in
                        tick.ascents.remove(atOffsets: indexSet)
                    }
                }
                Section(header: Text("Log")){
                    ForEach(tick.logItems) { logItem in
                        Label(logItem.date.formatDate(), systemImage: "paperplane")
                    }
                    .onDelete{ indexSet in
                        tick.logItems.remove(atOffsets: indexSet)
                    }
                }
            }
            VStack{
                Spacer()
                AddButtonView(action: {isLogging = true})
                    .font(.system(size: 40)) //Hardcoded copy of ticklist, fix!
            }
            
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {saveAction()}
        }
        .sheet(isPresented: $isLogging){
            NavigationView {
                AddLogItemView(logItem: $newLogItem)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                isLogging = false
                                newLogItem = Tick.LogItem()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction){
                            Button("Add"){
                                tick.logItems.append(newLogItem)
                                isLogging = false
                                newLogItem = Tick.LogItem()
                            }
                        }
                    }
            }
        }
    }
}

struct TickView_Previews: PreviewProvider {
    
    static var previews: some View {
        TickView(tick: .constant(Tick.sampleData.getTick(index: 0)!), saveAction: {})
    }
}
