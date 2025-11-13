//
//  MoodViewModel.swift
//  MoodMate
//
//  Created by Gis Cam on 07/11/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine

@MainActor
final class MoodViewModel: ObservableObject {
    @Published var isSaving: Bool = false
    @Published var saveSuccess: Bool = false
    @Published var saveError: String? = nil

    private let db = Firestore.firestore()
    private let collection = "moodLogs"

    func addMoodLog(emotionName: String, note: String?, date: Date) {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            saveError = "User not logged in"
            return
        }

        isSaving = true
        saveSuccess = false
        saveError = nil

        let log = MoodLogModel(
            emotionName: emotionName,
            note: note,
            date: date,
            userId: currentUserId
        )

        let data: [String: Any] = [
            "emotionName": log.emotionName,
            "note": log.note ?? "",
            "date": log.date.timeIntervalSince1970,
            "userId": log.userId
        ]

        db.collection(collection).document(log.id).setData(data) { [weak self] error in
            DispatchQueue.main.async {
                self?.isSaving = false
                if let error = error {
                    self?.saveError = "Error saving mood log: \(error.localizedDescription)"
                } else {
                    self?.saveSuccess = true
                }
            }
        }
    }
}
