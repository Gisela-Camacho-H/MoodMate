//
//  HomeViewModel.swift
//  MoodMate
//
//  Created by Gis Cam on 22/10/25.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var quoteOfTheDay: Quote?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let apiURL = URL(string: "https://moodmate-api-uirf.onrender.com/api/content/quotes")!
    

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchQuote()
    }
    
    func fetchQuote() {
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

            .decode(type: QuoteModel.self, decoder: JSONDecoder())
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
                
                if let randomQuote = response.inspirationalQuotes.randomElement() {
                    self.quoteOfTheDay = randomQuote
                } else {
                    self.errorMessage = "Empty data"
                }
            }
            .store(in: &cancellables)
    }
    
    func refreshQuote() {
        fetchQuote()
    }
}
