//
//  EmotionModel.swift
//  MoodMate
//
//  Created by Gis Cam on 22/10/25.
//

import Foundation

struct EmotionModel: Identifiable {
    let id = UUID()
    let name : String
    let iconName : String
}

extension EmotionModel {
    static let emotionList:  [EmotionModel] = [
        .init(name: "Grateful", iconName: "Grateful"),
        .init(name: "Apathy", iconName: "Apathy"),
        .init(name: "Empowered", iconName: "Empowered"),
        .init(name: "Inspired", iconName: "Inspired"),
        .init(name: "Joyful", iconName: "Joyful"),
        .init(name: "Content", iconName: "Content"),
        .init(name: "Hopeful", iconName: "Hopeful"),
        .init(name: "Calm", iconName: "Calm"),
        .init(name: "Curious", iconName: "Curious"),
        .init(name: "Anxious", iconName: "Anxious"),
        .init(name: "Sad", iconName: "Sad"),
        .init(name: "Overwhelmed", iconName: "Overwhelmed"),
        .init(name: "Frustrated", iconName: "Frustrated"),
        .init(name: "Stressed", iconName: "Stressed"),
        .init(name: "Lonely", iconName: "Lonely"),
        .init(name: "Confused", iconName: "Confused"),
        .init(name: "Grief", iconName: "Grief"),
        .init(name: "Irritated", iconName: "Irritated"),
        .init(name: "Vulnerable", iconName: "Vulnerable"),
        .init(name: "Resilient", iconName: "Resilient")
        
    ]
}
