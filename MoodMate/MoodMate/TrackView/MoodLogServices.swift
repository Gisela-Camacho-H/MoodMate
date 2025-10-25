//
//  MoodLogServices.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//

import Foundation
import Combine

protocol MoodLogServices {
    func fetchMoodLogs() -> AnyPublisher<[MoodLogModel], Error>
}

class MockMoodLogService: MoodLogServices {

    
    private let mockLogs: [MoodLogModel] = [
        MoodLogModel(id: "m1", emotionName: "Joyful", note: "Great day!", date: Date().addingTimeInterval(-86400*1)),
        MoodLogModel(id: "m2", emotionName: "Hopeful", note: "Feeling positive", date: Date().addingTimeInterval(-86400*3)),
        MoodLogModel(id: "m3", emotionName: "Anxious", note: "To much work", date: Date().addingTimeInterval(-86400*7)),
        MoodLogModel(id: "m4", emotionName: "Calm", note: "Meditated", date: Date().addingTimeInterval(-86400*10)),
        MoodLogModel(id: "m5", emotionName: "Content", note: nil , date: Date().addingTimeInterval(-86400*15))
    ]
    
    func fetchMoodLogs() -> AnyPublisher<[MoodLogModel], any Error> {
        return Future<[MoodLogModel], Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let sortedLog =  self.mockLogs.sorted(by: {$0.date > $1.date})
                promise(.success(sortedLog))
            }
        }
        .eraseToAnyPublisher()
    }
}
