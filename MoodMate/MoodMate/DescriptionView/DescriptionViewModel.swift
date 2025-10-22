//
//  DescriptionViewModel.swift
//  MoodMate
//
//  Created by Gis Cam on 22/10/25.
//

import Foundation
import Combine
import SwiftUI

class DescriptionViewModel: ObservableObject {
    
    @Published var descriptionText: String?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let emotionName: String
    private let apiURL = URL(string: "https://moodmate-api-uirf.onrender.com/api/content/description")!
    

    private var cancellables = Set<AnyCancellable>()
    
    init(emotionName: String) {
        self.emotionName = emotionName
        fetchDescription()
    }
    
    func fetchDescription() {
        self.isLoading = true
        self.errorMessage = nil
        

        URLSession.shared.dataTaskPublisher(for: apiURL)

            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }

            .decode(type: DescriptionResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)

            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .failure(let error):
   
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    print("Combine Error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let detailData =  response.descriptionContent[self.emotionName] {
                    self.descriptionText = detailData.description
                } else {
                    self.descriptionText = "This is a state of inner peace and stillness. You feel relaxed, unhurried, and mentally quiet, like the surface of a clear lake. There are no pressing worries, and you feel comfortable simply being in the moment."
                }
            }
            .store(in: &cancellables)
    }
}
