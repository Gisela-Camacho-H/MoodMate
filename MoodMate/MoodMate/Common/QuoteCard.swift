//
//  QuoteCard.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct QuoteCardHomeView: View {
    let quote: Quote?
    let isLoading: Bool
    
    
    var body: some View {
        
        let currentQuote = quote ?? Quote.defaultQuote
        
        VStack(spacing: 15) {
            
            if isLoading {
                ProgressView()
                    .padding(.vertical, 30)
            } else {
                Text("\"\(currentQuote.content)\"")
                    .font(.custom("AvenirNext-Bold", size: 20))
                    .foregroundColor(Color("BlueMood"))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.vertical, 25)
                
                HStack {
                    Spacer()
                    Text("by \(currentQuote.author)")
                        .font(.custom("AvenirNext-Bold", size: 20))
                        .foregroundColor(Color("CoralMood"))
                }
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("CoralMood"), lineWidth: 2)
        )
        .padding(.horizontal, 20)
    }
}
