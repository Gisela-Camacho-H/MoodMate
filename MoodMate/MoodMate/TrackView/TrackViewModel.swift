//
//  TrackViewModel.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//

import Foundation
import Combine

class TrackViewModel: ObservableObject {
    @Published var moodLogs: [MoodLogModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var service: MoodLogServices
    private var cancellables = Set<AnyCancellable>()
    
    
    init(service: MoodLogServices) {
        self.service = service
        fetchMoodLogs()
    }
    
    func fetchMoodLogs() {
        isLoading = true
        errorMessage =  nil
        
        service.fetchMoodLogs()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] competion in
                guard let self =  self else { return }
                self.isLoading = false
                
                if case .failure(let error) = competion {
                    self.errorMessage = "Failed to fetch mood logs: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] logs in
                self?.moodLogs = logs
            }
            .store(in: &cancellables)
    }
    
    func refreshLogs() {
        fetchMoodLogs()
    }
    
}
