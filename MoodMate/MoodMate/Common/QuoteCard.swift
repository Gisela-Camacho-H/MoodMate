//
//  QuoteCard.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct QuoteCardView: View {
    let quote: String
    let author: String
    
    var body: some View {
        VStack(spacing: 15) {
            Text(quote)
                .font(.custom("AvenirNext-Bold", size: 20))
                .foregroundColor(Color("BlueMood"))
                .multilineTextAlignment(.center)
                .padding(.vertical, 25)
            
            HStack {
                Spacer()
                Text("by \(author)")
                    .font(.custom("AvenirNext-Bold", size: 20))
                    .foregroundColor(Color("CoralMood"))
            }
            .padding(.trailing, 15)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("CoralMood"), lineWidth: 2)
        )
        .padding(.horizontal, 30)
    }
}
