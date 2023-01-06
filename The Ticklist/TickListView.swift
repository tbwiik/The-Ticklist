//
//  TickListView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 05/01/2023.
//

import SwiftUI

struct TickListView: View {
    
    @Binding var ticklist: [Tick]
    @State private var isAdding = false
    @State private var newTickData = Tick.Data()
    let saveAction: () -> Void
    
    var body: some View {
        ZStack {
            List {
                ForEach($ticklist) { $tick in
                    NavigationLink(destination: {TickView(tick: $tick)}){
                        CardView(tick: tick)
                            .swipeActions(edge: .leading){
                                Button("Delete", role: .destructive){
                                    ticklist.remove(at: ticklist.firstIndex(where: {$0 == tick})!)
                                    saveAction() //TODO change on scenechange
                                }
                            }
                    }
                }
            }
            VStack {
                Spacer()
                Button(action: {
                    isAdding = true
                }){
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.green)
                }
            }
        }
        .navigationTitle("Ticklist")
        .sheet(isPresented: $isAdding){
            NavigationView {
                TickEditView(data: $newTickData)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                isAdding = false
                                newTickData = Tick.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction){
                            Button("Add"){
                                ticklist.append(Tick(data: newTickData))
                                isAdding = false
                                newTickData = Tick.Data()
                                saveAction() //TODO save on scenechange
                                
                            }
                        }
                    }
            }
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
