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
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("AvenirNext-Bold", size: isIPad ? 40 : 32))
                .foregroundColor(.white)
                .padding(.vertical,isIPad ? 10 : 5)
                .frame(maxWidth: .infinity)
                .background(Color("BlueMood"))
                .cornerRadius(isIPad ? 25 : 20)
                .shadow(color: Color.shadowMood.opacity(0.15), radius: 10, x: 0, y: 10)
        }
        .padding(.horizontal, isIPad ? 60 : 40)
        .padding(.vertical, isIPad ? 25 : 20)
    }
}
