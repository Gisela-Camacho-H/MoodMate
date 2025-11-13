//
//  TrackViewModel.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//

import Foundation
import Combine
import FirebaseAuth

class TrackViewModel: ObservableObject {
    @Published var moodLogs: [MoodLogModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let moodService: MoodLogServiceProtocol

    init(moodService: MoodLogServiceProtocol = MoodLogService()) {
        self.moodService = moodService
    }

    func fetchMoodLogs() {
        guard Auth.auth().currentUser != nil else {
            self.moodLogs = []
            return
        }

        isLoading = true
        errorMessage = nil

        moodService.fetchMoodLogs { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let logs):
                    self?.moodLogs = logs
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
