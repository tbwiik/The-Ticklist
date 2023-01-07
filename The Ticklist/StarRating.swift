//
//  StarRating.swift
//  The Ticklist
//
//  Created by Torbjørn Wiik on 07/01/2023.
//

import SwiftUI

struct StarRating: View {
    
    @Binding var rating: Int
    
    var body: some View {
        HStack{
            ForEach(1..<6){ number in
                Image(systemName: number <= rating ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating(rating: .constant(3))
            .previewLayout(.sizeThatFits)
    }
}
