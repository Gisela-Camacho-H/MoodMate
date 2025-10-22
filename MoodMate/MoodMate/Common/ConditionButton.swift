//
//  ConditionButton.swift
//  MoodMate
//
//  Created by Gis Cam on 22/10/25.
//

import SwiftUI

struct ConditionButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
                Text(title)
                    .font(.custom("AvenirNext-Bold", size: 32))
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity)
                        .background(Color("BlueMood"))
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 20)
    }
}
