//
//  ContentModel.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//
import Foundation

struct ContentModel: Decodable, Identifiable {
    let text: String
    let author: String?
    let reference: String?
    
    var id: String { reference ?? author ?? text }
}

struct EmotionSupportContent: Decodable {
    let scriptures: [ContentModel]
    let quotes: [ContentModel]
}


struct EmotionSupportResponse: Decodable {
    let supportContent: [String: EmotionSupportContent]
    
    enum CodingKeys: String, CodingKey {
        case supportContent = "support_content"
    }
}
