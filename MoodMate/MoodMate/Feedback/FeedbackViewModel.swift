//
//  FeedbackViewModel.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//

import Foundation
import Combine

class FeedbackViewModel: ObservableObject {
    
    @Published var  randomQuotes: ContentModel?
    @Published var  randomScripture: ContentModel?
    @Published var  isLoading: Bool = false
    @Published var  errorMessage: String?
    
    private let emotionName: String
    private let apiURL = URL(string: "https://moodmate-api-uirf.onrender.com/api/content/all")!
    
    private var cancellables: Set<AnyCancellable> = []
    init(emotionName: String) {
        self.emotionName = emotionName
        fetchContent()
    }
    
    func fetchContent() {
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
        
            .decode(type: EmotionSupportResponse.self, decoder: JSONDecoder())
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
                
                if let supportData = response.supportContent[self.emotionName] {
                    self.randomQuotes = supportData.quotes.randomElement()
                    
                    if self.emotionName == "Anxious",
                       let specificScripture = supportData.scriptures.first(where: { $0.reference == "D&C 6:36" }) {
                        self.randomScripture =  specificScripture
                    } else { self.randomScripture =  supportData.scriptures.randomElement()
                    }
                } else {
                    self.errorMessage = "Content not founf '\(self.emotionName)'."
                }
            }
            .store(in: &cancellables)
    }
}
