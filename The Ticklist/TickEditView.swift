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
                TextField("Name", text: $data.name)
                TextField("Region", text: $data.region)
                Picker("Dicipline", selection: $data.dicipline){
                    ForEach(Dicipline.allCases){ dicipline in
                        Text(dicipline.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                DatePicker(
                    "Climbed",
                    selection: $data.ascents[0].date, //Potential error here due to choice of first index
                    displayedComponents: .date
                )
                TextField("Grade", text: $data.grade)
                StarRating(rating: $data.rating)
            }
        }
    }
}

struct TickEditView_Previews: PreviewProvider {
    static var previews: some View {
        TickEditView(data: .constant(Tick.Data()))
    }
}
