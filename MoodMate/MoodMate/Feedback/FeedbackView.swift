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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
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
                    VStack(alignment: .center, spacing:  isIPad ? 40 : 10) {
                        Text("Here's a little light for your journey")
                            .font(.custom("AvenirNext-Bold", size: isIPad ? 45 : 20))
                            .foregroundColor(Color("CoralMood"))
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, isIPad ? 20 : 15)
                            .padding(.top)
                        
                        QuoteCardFeedback(
                            text: quote.text,
                            author: quote.author ?? "Unknown",
                            color: Color("CoralMood"))
                        
                    }
                    .padding(.horizontal, isIPad ? 40 : 25)
                    
                }
                
                if let scripture = viewModel.randomScripture {
                    VStack(alignment: .center, spacing: isIPad ? 45 : 10) {
                        Text("God's word for your moment ")
                            .font(.custom("AvenirNext-Bold", size: isIPad ? 40 : 20))
                            .foregroundColor(Color("CoralMood"))
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, isIPad ? 20 : 15)
                            .padding(.top)
                        
                        ScriptureCard(
                            text: scripture.text,
                            reference: scripture.reference ?? "Reference Unknown",
                            color: Color("CoralMood"))
                        
                    }
                    .padding(.horizontal, isIPad ? 40 : 25)
                    
                }
                
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: isIPad ? 30 : 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(isIPad ? 15 : 10)
                            .background(Color("CoralMood"))
                            .clipShape(Circle())
                            .shadow(color: .shadowMood.opacity(0.3), radius: 10, x: 0, y:10)
                        
                    }
                    .padding(.leading, isIPad ? 35 : 25)
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
