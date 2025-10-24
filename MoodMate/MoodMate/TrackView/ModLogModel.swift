//
//  ModLogModel.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//

import Foundation
import SwiftUI

struct ModLogModel: Identifiable, Decodable {
    let id: String
    let emotionName: String
    let note: String?
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case emotionName = "emotion"
        case note
        case date
    }
}

typealias MoodTrackResponse = [ModLogModel]

