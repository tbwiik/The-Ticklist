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
    
    private var isAscents: Bool {
        !tick.ascents.isEmpty
    }
    
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
                    if isAscents{
                        Label(tick.ascents[0].date.formatDate(), systemImage: "calendar.badge.exclamationmark")
                        Label("\(tick.ascents[0].numberOfTries) Tries", systemImage: "number")
                        StarRating(rating: $tick.rating)
                    }
                }
                //TODO: Bad animation
                if isAscents{
                    Section(header: Text("Ascents")){
                        ForEach(tick.ascents){ ascent in
                            Label(ascent.date.formatDate(), systemImage: "bolt")
                        }
                        .onDelete{ indexSet in
                            tick.ascents.remove(atOffsets: indexSet)
                            if tick.ascents.isEmpty{
                                tick.rating = 0
                            }
                        }
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
                AddLogItemView(rating: $tick.rating, logItem: $newLogItem)
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
                                if (newLogItem.isTop){
                                    tick.ascents.append(newLogItem)
                                }
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
