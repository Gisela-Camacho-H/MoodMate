//
//  QuoteCard.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct QuoteCardView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("\"If you can dream it, \nyou can do it.\"")
                .font(.custom("AvenirNext-Bold", size: 20))
                .foregroundColor(Color("BlueMood"))
                .multilineTextAlignment(.center)
                .padding(.vertical, 25)
            
            HStack {
                Spacer()
                Text("by Walt Disney")
                    .font(.custom("AvenirNext-Bold", size: 20))
                    .foregroundColor(Color("CoralMood"))
            }
            .padding(.trailing, 15)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color("White"))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("CoralMood"), lineWidth: 2)
        )
        .padding(.horizontal, 30)
    }
}
