//
//  TickListView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 05/01/2023.
//

import SwiftUI

struct TickListView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @Binding var ticklist: TickList
    @State private var isAdding = false
    @State private var newTickData = Tick.Data()
    
    let saveAction: () -> Void
    
    var body: some View {
        ZStack {
            List {
                ForEach($ticklist.ticks) { $tick in
                    NavigationLink(destination: {TickView(tick: $tick, saveAction: saveAction)}){
                        CardView(tick: tick)
                        //Swipe to delete, left to right
                            .swipeActions(edge: .leading){
                                Button("Delete", role: .destructive){
                                    ticklist.remove(tickToRemove: tick)
                                }
                            }
                    }
                }
            }
            VStack {
                Spacer()
                AddButtonView(action: {isAdding = true})
                    .font(.system(size: 40))
                    .accessibilityLabel("Add climb")
            }
        }
        .navigationTitle("Ticklist")
        .sheet(isPresented: $isAdding){
            NavigationView {
                AddClimbView(data: $newTickData)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                isAdding = false
                                newTickData = Tick.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction){
                            Button("Add"){
                                let tick = Tick(data: newTickData)
                                ticklist.add(tickToAdd: tick)
                                DatabaseManager.saveTick(tick: tick)
                                isAdding = false
                                newTickData = Tick.Data()
                            }
                            .disabled(!newTickData.isComplete)
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {saveAction()}
        }
    }
}

struct TickListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TickListView(ticklist: .constant(Tick.sampleData), saveAction: {})
        }
    }
}
