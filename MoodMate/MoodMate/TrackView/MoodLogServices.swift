//
//  MoodLogServices.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol MoodLogServiceProtocol {
    func fetchMoodLogs(completion: @escaping (Result<[MoodLogModel], Error>) -> Void)
    func saveMoodLog(_ log: MoodLogModel, completion: @escaping (Bool) -> Void)
}

final class MoodLogService: MoodLogServiceProtocol {
    private let db = Firestore.firestore()
    private let collection = "moodLogs"

    func fetchMoodLogs(completion: @escaping (Result<[MoodLogModel], Error>) -> Void) {
        
 
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            completion(.success([]))
            return
        }
        
        db.collection("moodLogs")
            .whereField("userId", isEqualTo: currentUserId)
            .order(by: "date", descending: true)
            .getDocuments { snapshot, error in
                
                if let error = error {
                    print("❌ Error de Firestore al obtener logs: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }

                let logs = snapshot?.documents.compactMap {
         
                     MoodLogModel(document: $0.data(), id: $0.documentID)
                } ?? []
                
                completion(.success(logs))
            }
    }

    func saveMoodLog(_ log: MoodLogModel, completion: @escaping (Bool) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }

        let data: [String: Any] = [
            "emotionName": log.emotionName,
            "note": log.note ?? "",
            "date": log.date.timeIntervalSince1970,
            "userId": currentUserId
        ]

        db.collection(collection).document(log.id).setData(data) { error in
            completion(error == nil)
        }
    }
}
