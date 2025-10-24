//
//  MoodView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct MoodView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedEmotion: EmotionModel? = nil
    @State private var userThought: String = ""
    @ObservedObject var tabManager: TabManager
    
    @State private var emotionForFeedback: EmotionModel? = nil
    
    let columns =  [
        GridItem(.flexible(minimum: 60)),
        GridItem(.flexible(minimum: 60)),
        GridItem(.flexible(minimum: 60)),
        GridItem(.flexible(minimum: 60)),
        GridItem(.flexible(minimum: 60))
    ]
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("BaseMood").ignoresSafeArea(.all)
            ScrollView {
                VStack {
                    Text("How are you doing today?")
                        .font(.custom("AvenirNext-Bold", size: 26))
                        .foregroundColor(Color("CoralMood"))
                        .padding(.top, 20)
                    
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(EmotionModel.emotionList) { emotion in
                            EmotionGridItem(emotion: emotion, selectedEmotion: $selectedEmotion)
                        }
                    }
                    .padding(.vertical, 20)
                    .background(.white)
                    
                    VStack(spacing: 10) {
                        Text("Share what's on your mind")
                            .font(.custom("AvenirNext-Bold", size: 24))
                            .foregroundColor(Color("CoralMood"))
                            .padding(.bottom, 10)
                        
                        TextEditor(text: $userThought)
                            .frame(height: 100)
                            .cornerRadius(15)
                            .padding(8)
                            .background(Color.white)
                            .foregroundColor(Color("BlueMood"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color("CoralMood"), lineWidth: 3)
                            )
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    
                    ConditionButton(title: "Lift me up") {
                        if let emotion =  selectedEmotion {
                            emotionForFeedback = emotion
                        }
                    }
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                .padding(.top, 0)
                .navigationBarHidden(true)
                .scrollDismissesKeyboard(.interactively)
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
        .fullScreenCover(item: $emotionForFeedback) { emotion in
            FeedbackView(selectedEmotion: emotion)
        }
    }
}
    
    #Preview {
        let tabManager = TabManager()
        MoodView(tabManager: tabManager)
    }
    
    
    extension UIApplication {
        func endEditing() {
            sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
