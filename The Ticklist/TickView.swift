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
    
    init(_ tick: Binding<Tick>) {
        self._tick = tick
    }
    
    private func addLogAction(){
        tick.logItems.append(newLogItem)
        isLogging = false
        newLogItem = Tick.LogItem()
    }
    
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
                    if tick.isAscents{
                        Label(tick.firstAscent!.date.formatDate(), systemImage: "calendar.badge.exclamationmark")
                        Label("\(tick.firstAscent!.numberOfTries) Tries", systemImage: "number")
                        StarRating(rating: $tick.rating)
                    }
                }
                //TODO: Bad animation
                if tick.isAscents{
                    Section(header: Text("Ascents")){
                        ForEach(tick.logItems.filter {$0.isTop}){ ascent in
                            Label(ascent.numberOfTries.formatted(), systemImage: "bolt")
                        }
                    }
                }
                Section(header: Text("Log")){
                    ForEach(tick.logItems) { logItem in
                        Label(logItem.numberOfTries.formatted(), systemImage: "paperplane")
                    }
                    .onDelete{ indexSet in
                        tick.logItems.remove(atOffsets: indexSet)
                    }
                }
            }
            VStack{
                Spacer()
                AddButtonView(action: {isLogging = true})
            }
            
        }
        .sheet(isPresented: $isLogging, onDismiss: {newLogItem = Tick.LogItem()}){
            AddLogItemView(rating: $tick.rating, logItem: $newLogItem, action: {addLogAction()})
        }
    }
}

struct TickView_Previews: PreviewProvider {
    
    static var previews: some View {
        TickView(.constant(Tick.sampleData.getTick(0)!))
    }
}
