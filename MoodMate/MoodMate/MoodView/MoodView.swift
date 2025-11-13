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
    @State private var showFeedback = false
    
    @StateObject private var viewModel = MoodViewModel()
    
    let columns = [
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
                        
                        ZStack(alignment: .topLeading) {
                                
                                RoundedRectangle(cornerRadius: 20)
                                .fill(Color.whiteMood)
                                    .stroke(Color("CoralMood"), lineWidth: 4)
                                
                                TextEditor(text: $userThought)
                                    .scrollContentBackground(.hidden)
                                    .background(Color.clear)
                                    .foregroundColor(Color("BlueMood"))
                                    .padding(10)
                            }
                            .frame(height: 100)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    
                    ConditionButton(title: viewModel.isSaving ? "Saving..." : "Lift me up") {
                        guard let emotion = selectedEmotion else { return }
                        emotionForFeedback = emotion
                        viewModel.addMoodLog(
                            emotionName: emotion.name,
                            note: userThought,
                            date: Date()
                        )
                    }
                    .disabled(viewModel.isSaving || selectedEmotion == nil)
                    .opacity(viewModel.isSaving ? 0.6 : 1)
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
        .onChange(of: viewModel.saveSuccess) { success in
            if success, emotionForFeedback != nil {
                showFeedback = true
            }
        }
        .fullScreenCover(isPresented: $showFeedback) {
            if let emotion = emotionForFeedback {
                FeedbackView(selectedEmotion: emotion)
            }
        }
        .alert("Error", isPresented: Binding<Bool>(
            get: { viewModel.saveError != nil },
            set: { _ in viewModel.saveError = nil }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.saveError ?? "")
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
