//
//  AddLogItemView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 11/01/2023.
//

import SwiftUI

struct AddLogItemView: View {
    
    @Binding var rating: Int
    @Binding var logItem: Tick.LogItem
    
    var body: some View {
        Form{
            Section(header: Text("Log")){
                DatePicker(
                    "Log-Date",
                    selection: $logItem.date, //Potential error here due to choice of first index
                    displayedComponents: .date
                )
                Picker("Number of tries", selection: $logItem.numberOfTries){
                    ForEach(0..<10){num in
                        Text("\(num)")
                    }
                }
                Toggle("Topout", isOn: $logItem.isTop)
                TextField("Comment", text: $logItem.comment)
                if(logItem.isTop){
                    StarRating(rating: $rating)
                }
            }
        }
    }
}

struct AddLogItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddLogItemView(rating: .constant(2),
                       logItem: .constant(Tick.sampleLogItems[0]))
    }
}
