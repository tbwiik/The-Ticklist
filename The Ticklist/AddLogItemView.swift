//
//  AddLogItemView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 11/01/2023.
//

import SwiftUI

struct AddLogItemView: View {
    
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
                    ForEach(1..<10){num in
                        Text("\(num)")
                    }
                }
                Toggle("Topout", isOn: $logItem.isTop)
                TextField("Comment", text: $logItem.comment)
            }
        }
    }
}

struct AddLogItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddLogItemView(logItem: .constant(Tick.sampleLogItems[0]))
    }
}
