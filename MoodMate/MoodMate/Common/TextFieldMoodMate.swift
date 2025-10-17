//
//  TextFieldMoodMate.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct TextFieldMoodMate: ViewModifier {
    let iconName: String
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            HStack {
                    Image(systemName: iconName)
                        .foregroundColor(Color("BlueMood"))
                    content
                    .font(.custom("AvenirNext-Bold", size: 20))
            }
            .padding(.bottom, 15)
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color("CoralMood"))
                .padding(.horizontal, 0)
        }
        .padding(.top, 15)
        .padding(.horizontal, 15)
        .cornerRadius(12)
    }
}
