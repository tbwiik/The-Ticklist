//
//  TickListView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 05/01/2023.
//

import SwiftUI

struct TickListView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var persistenceViewModel: PersistenceViewModel
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isAdding = false
    @State private var showProfileView = false
    @State private var newTickData = Tick.Data()
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    
    /// Handle storage actions, functions run for persistence
    ///
    /// This function clean up code other places in file
    /// - Parameter action: storage action to be executed
    private func storageAction(_ action: @escaping () async throws-> Void){
        Task {
            do {
                try await action()
            } catch {
                isError = true
                errorMessage = error.localizedDescription
            }
        }
    }
    
    
    /// Delete ticks at given offsets
    ///
    /// Note that the indexSet given must be equal to backend list.
    /// In other words: if the visual order does not match backend the correct indexSet must be passed in.
    ///
    /// - Parameter offsets: indexes of ticks in visual list
    private func deleteTicks(at offsets: IndexSet){
        
        let ticksToDelete = offsets.compactMap { index in
            persistenceViewModel.ticklist.getTick(index)
        }
        
        for tick in ticksToDelete{
            storageAction {
                try await persistenceViewModel.deleteTick(tick)
            }
        }
    }
    

    
    var body: some View {
        NavigationStack{
            ZStack {
                List{
                    ForEach($persistenceViewModel.ticklist.ticks) { $tick in
                        NavigationLink {
                            TickView($tick)
                        } label: {
                            CardView(tick: tick)
                        }
                    }
                    .onDelete(perform: deleteTicks)
                }
                VStack {
                    Spacer()
                    AddButtonView(action: {isAdding = true})
                        .accessibilityLabel("Add climb")
                }
            }
        }
        .navigationTitle("Ticklist")
        .alert("Error occured", isPresented: $isError){
            Button("Cancel", role: .cancel){
                errorMessage = ""
            }
        } message: {
            Text(errorMessage)
        }
        .sheet(isPresented: $isAdding){
            VStack{
                HStack(alignment: .top){
                    Button("Cancel"){
                        isAdding = false
                        newTickData = Tick.Data()
                    }
                    Spacer()
                    Button("Add"){
                        let tick = Tick(data: newTickData)
                        storageAction { try persistenceViewModel.saveTick(tick) }
                        isAdding = false
                        newTickData = Tick.Data()
                    }
                    .disabled(!newTickData.isComplete)
                }
                .padding()
                .background()
                AddClimbView(data: $newTickData)
            }
        }
    }
}

struct TickListView_Previews: PreviewProvider {
    static var previews: some View {
        TickListView()
    }
}
