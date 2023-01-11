//
//  TickEditView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 05/01/2023.
//

import SwiftUI

struct TickEditView: View {
    
    @Binding var data: Tick.Data
    
    var body: some View {
        Form {
            Section(header: Text("Info")) {
                Picker("Dicipline", selection: $data.dicipline){
                    ForEach(Dicipline.allCases){ dicipline in
                        Text(dicipline.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                TextField("Name", text: $data.name)
                TextField("Region", text: $data.region)
                TextField("Grade", text: $data.grade)
            }
        }
    }
}

struct TickEditView_Previews: PreviewProvider {
    static var previews: some View {
        TickEditView(data: .constant(Tick.Data()))
    }
}
