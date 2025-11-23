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
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
    var body: some View {
        
        let currentQuote = quote ?? Quote.defaultQuote
        
        VStack(spacing: 15) {
            
            if isLoading {
                ProgressView()
                    .padding(.vertical, 30)
            } else {
                Text("\"\(currentQuote.content)\"")
                    .font(.custom("AvenirNext-Bold", size: isIPad ? 30 : 20))
                    .foregroundColor(Color("BlueMood"))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.vertical, isIPad ? 30 : 25)
                
                HStack {
                    Spacer()
                    Text("by \(currentQuote.author)")
                        .font(.custom("AvenirNext-Bold", size: isIPad ? 30 :  20))
                        .foregroundColor(Color("CoralMood"))
                }
            }
        }
        .padding(.vertical, isIPad ? 20 : 15)
        .padding(.horizontal, isIPad ? 30 : 25)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(isIPad ? 15 : 10)
        .overlay(
            RoundedRectangle(cornerRadius: isIPad ? 15 : 10)
                .stroke(Color("CoralMood"), lineWidth: isIPad ? 3 : 2)
        )
        .padding(.horizontal, isIPad ? 25 : 20)
    }
}

#Preview {
    QuoteCardHomeView(quote: Quote(author: "Ralph Waldo Emerson", content: "The only person you are destined to become is the person you decide to be."), isLoading: false)
}
