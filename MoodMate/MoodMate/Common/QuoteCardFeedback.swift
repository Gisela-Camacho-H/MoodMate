//
//  QuoteCardFeedback.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//

import SwiftUI

struct QuoteCardFeedback: View {
    
    let text: String
    let author: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("\"\(text)\"")
                .font(.custom("AvenirNext-Bold", size: 18))
                .foregroundColor(Color("GrayMood"))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            Text("by \(author)")
                .font(.custom("AvenirNext-Bold", size: 15))
                .foregroundColor(Color("BlueMood"))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(25)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(color, lineWidth: 2)
        )
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
        
    }
}
