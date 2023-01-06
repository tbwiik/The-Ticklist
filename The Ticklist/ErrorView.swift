//
//  ErrorView.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 06/01/2023.
//

import SwiftUI

struct ErrorView: View {
    
    let errorWrapper: ErrorWrapper
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("An error occured")
                    .font(.title)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                    .padding()
                Text(errorWrapper.solution)
                    .font(.caption)
                    .bold()
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Dismiss"){
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    
    enum SampleError: Error {
        case sampleError
    }
    
    static var errorWrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.sampleError, solution: "Ignore warning")
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: errorWrapper)
    }
}
