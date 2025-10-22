//
//  QuoteModel.swift
//  MoodMate
//
//  Created by Gis Cam on 22/10/25.
//

import Foundation

struct QuoteModel: Decodable {
    let inspirationalQuotes: [Quote]
    
    private enum CodingKeys: String, CodingKey {
        case inspirationalQuotes = "inspirational_quotes"
    }
}


struct Quote: Decodable, Identifiable {
    let id = UUID().uuidString
    let author: String
    let content: String
    
    private enum CodingKeys: String, CodingKey {
        case author
        case content = "text"
    }
    
    static let defaultQuote = Quote(
        author: "Walt Disney",
        content: "If you can dream it, you can do it")
}
