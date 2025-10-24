//
//  FeedbackView.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//

import SwiftUI

struct FeedbackView: View {
    
    let selectedEmotion : EmotionModel
    
    @StateObject private var viewModel: FeedbackViewModel
    @Environment(\.dismiss) var dismiss
    
    init(selectedEmotion: EmotionModel) {
        self.selectedEmotion = selectedEmotion
        _viewModel = StateObject(wrappedValue: FeedbackViewModel(emotionName: selectedEmotion.name))
    }
    var body: some View {
        ZStack {
            Color("BaseMood").ignoresSafeArea(.all)
            
            VStack(spacing: 50) {
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView("Loading")
                        .padding(50)
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding(50)
                }
                
                if let quote = viewModel.randomQuotes {
                    VStack(alignment: .center, spacing: 10) {
                        Text("Here's a little light for your journey")
                            .font(.custom("AvenirNext-Bold", size: 20))
                            .foregroundColor(Color("CoralMood"))
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 15)
                            .padding(.top)
                        
                        QuoteCardFeedback(
                            text: quote.text,
                            author: quote.author ?? "Unknown",
                            color: Color("CoralMood"))
                        
                    }
                    .padding(.horizontal, 25)
                    
                }
                
                if let scripture = viewModel.randomScripture {
                    VStack(alignment: .center, spacing: 10) {
                        Text("God's word for your moment ")
                            .font(.custom("AvenirNext-Bold", size: 20))
                            .foregroundColor(Color("CoralMood"))
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 15)
                            .padding(.top)
                        
                        ScriptureCard(
                            text: scripture.text,
                            reference: scripture.reference ?? "Reference Unknown",
                            color: Color("CoralMood"))
                        
                    }
                    .padding(.horizontal, 25)
                    
                }
                
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(Color("CoralMood"))
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y:5)
                        
                    }
                    .padding(.leading, 25)
                    Spacer()
                }
                Spacer()
            }
                .padding(.bottom, 80)
        }
    }
}

extension EmotionModel {
    static var sampleEmotion: EmotionModel {
        EmotionModel(name: "Grateful", iconName: "Grateful")
    }
}
#Preview {
    FeedbackView(selectedEmotion: EmotionModel.sampleEmotion)
}
