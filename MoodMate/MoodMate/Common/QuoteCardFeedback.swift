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
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: isIPad ? 25 : 15) {
            Text("\"\(text)\"")
                .font(.custom("AvenirNext-Bold", size: isIPad ? 28 : 18))
                .foregroundColor(Color("GrayMood"))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            Text("by \(author)")
                .font(.custom("AvenirNext-Bold", size: isIPad ? 25 : 15))
                .foregroundColor(Color("BlueMood"))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(isIPad ? 35 : 25)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(isIPad ? 15 : 10)
        .overlay(
            RoundedRectangle(cornerRadius:isIPad ? 15 : 10)
                .stroke(color, lineWidth: isIPad ? 3 : 2)
        )
        .shadow(color: .shadowMood.opacity(0.1), radius: 10, x: 0, y: 10)
        
    }
}

#Preview {
    QuoteCardFeedback(text: "As we seek Him, as we learn of Him, as we come to Him, we find rest from the cares of this world.", author: "Russell M. Nelson", color: Color("CoralMood"))
}
