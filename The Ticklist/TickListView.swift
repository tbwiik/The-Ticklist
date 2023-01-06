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
                        Text(tick.name)
                    }
                }
            }
            VStack {
                Spacer()
                Button(action: {
                    isAdding = true
                }){
                    Image(systemName: "plus.circle")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
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
