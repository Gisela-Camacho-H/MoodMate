//
//  EmotionGridItem.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//

import SwiftUI

struct EmotionGridItem: View {
    
    let emotion: EmotionModel
    @Binding var selectedEmotion: EmotionModel?
    
    var isSectected: Bool {
        selectedEmotion?.id == emotion.id
    }
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
    var body: some View {
        Image(emotion.iconName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: isIPad ? 90 : 60, height: isIPad ? 90 : 60)
            .padding(5)
            .opacity(isSectected ? 0.8 : 1.0)
            .scaleEffect(isSectected ? 1.5 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isSectected)
            .onTapGesture {
                selectedEmotion = isSectected ? nil : emotion
            }
    }
}

#Preview {
    EmotionGridItem(emotion: .init(name: "Happy", iconName: "happy"), selectedEmotion: .constant(nil))
}
