//
//  DescriptionModel.swift
//  MoodMate
//
//  Created by Gis Cam on 22/10/25.
//

import Foundation

struct DescriptionModel: Decodable {
    let description: String
}

struct DescriptionResponse: Decodable {
    let descriptionContent: [String: DescriptionModel]
    
    enum CodingKeys: String, CodingKey {
        case descriptionContent = "description_content"
    }
}
