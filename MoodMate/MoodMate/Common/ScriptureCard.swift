//
//  ScriptureCard.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//

import SwiftUI


struct ScriptureCard: View {
    let text: String
    let reference: String
    let color: Color
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: isIPad ? 25 : 15) {
            Text(reference)
                .font(.custom("AvenirNext-Bold", size: isIPad ? 30 : 20))
                .foregroundColor(Color("BlueMood"))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(text)
                .font(.custom("AvenirNext-Bold", size:  isIPad ? 25 : 18))
                .foregroundColor(Color("GrayMood"))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding( isIPad ? 35 : 25)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius( isIPad ? 15 : 10)
        .overlay(
            RoundedRectangle(cornerRadius: isIPad ? 15 :  10)
                .stroke(color, lineWidth: isIPad ? 3 : 2)
        )
        .shadow(color: .shadowMood.opacity(0.1), radius: 10, x: 0, y: 10)
        
    }
}

#Preview {
    ScriptureCard(text: "Peace I leave with you, my peace I give unto you … Let not your heart be troubled, neither let it be afraid.", reference: "John 14:27", color: Color.blueMood)
}
