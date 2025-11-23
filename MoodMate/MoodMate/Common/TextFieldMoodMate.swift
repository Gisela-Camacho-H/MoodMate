//
//  TextFieldMoodMate.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct TextFieldMoodMate: ViewModifier {
    let iconName: String
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: isIPad ? 30 : 15) {
                    Image(systemName: iconName)
                        .foregroundColor(Color("BlueMood"))
                        .font(.system(size: isIPad ? 35 : 15, weight: .bold))
                    content
                    .font(.custom("AvenirNext-Bold", size: isIPad ? 30 : 20))
            }
            .padding(.bottom, isIPad ? 30 : 15)
            
            Rectangle()
                .frame(height: isIPad ? 4 : 2)
                .foregroundColor(Color("CoralMood"))
                .padding(.horizontal, 0)
        }
        .padding(.top, isIPad ? 30 : 15)
        .padding(.horizontal, isIPad ? 30 : 15)
        .cornerRadius(isIPad ? 20 : 12)
    }
}
