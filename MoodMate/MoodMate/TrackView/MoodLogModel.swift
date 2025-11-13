//
//  MoodLogModel.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//

import Foundation

struct MoodLogModel: Identifiable, Codable {
    let id: String
    let emotionName: String
    let note: String?
    let date: Date
    let userId: String

    init?(document: [String: Any], id: String) {
        guard let emotionName = document["emotionName"] as? String,
              let timestamp = document["date"] as? TimeInterval,
              let userId = document["userId"] as? String else { return nil }

        self.id = id
        self.emotionName = emotionName
        self.note = document["note"] as? String
        self.date = Date(timeIntervalSince1970: timestamp)
        self.userId = userId
    }

    init(id: String = UUID().uuidString, emotionName: String, note: String?, date: Date, userId: String) {
        self.id = id
        self.emotionName = emotionName
        self.note = note
        self.date = date
        self.userId = userId
    }
}
