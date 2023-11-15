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
    @State private var errorWrapper: ErrorWrapper?
    
    private func storageAction(_ action: @escaping () async throws-> Void){
        Task {
            do {
                try await action()
            } catch {
                errorWrapper = ErrorWrapper(error: error, solution: "TBD")
            }
        }
    }
    

    
    var body: some View {
        ZStack {
            List {
                ForEach($persistenceViewModel.ticklist.ticks) { $tick in
                    NavigationLink(destination: {TickView($tick)}){
                        CardView(tick: tick)
                        //Swipe to delete, left to right
                        .swipeActions(edge: .leading){
                            Button("Delete", role: .destructive){
                                storageAction { try await persistenceViewModel.deleteTick(tick)}
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
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        showProfileView = true
                    } label: {
                        Image(systemName: "person.circle")
                            .padding()
                            .font(.system(size: 20))
                    }

                }
            }
            
        }
        .navigationTitle("Ticklist")
        .sheet(isPresented: $showProfileView){
            NavigationView {
                ProfileView()
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                showProfileView = false
                            }
                        }
                    }
            }
        }
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
                                storageAction { try persistenceViewModel.saveTick(tick) }
                                isAdding = false
                                newTickData = Tick.Data()
                            }
                            .disabled(!newTickData.isComplete)
                        }
                    }
            }
        }
        // Display errormessage
        .sheet(item: $errorWrapper) { wrapped in
            ErrorView(errorWrapper: wrapped)
        }
    }
}

struct TickListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TickListView()
        }
    }
}
