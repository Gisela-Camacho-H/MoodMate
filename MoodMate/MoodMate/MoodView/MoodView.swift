//
//  MoodView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct MoodView: View {
    @State private var selectedEmotion: EmotionModel? = nil
    @State private var userThought: String = ""
    @State private var emotionForFeedback: EmotionModel? = nil
    @State private var showFeedback = false
    
    @ObservedObject var tabManager: TabManager
    @StateObject private var viewModel = MoodViewModel()
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
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
                        .font(.custom("AvenirNext-Bold", size: isIPad ? 40 : 26))
                        .foregroundColor(Color("CoralMood"))
                        .padding(.top, isIPad ? 40 : 20)
                    
                    LazyVGrid(columns: columns, spacing: isIPad ? 10 : 5) {
                        ForEach(EmotionModel.emotionList) { emotion in
                            EmotionGridItem(emotion: emotion, selectedEmotion: $selectedEmotion)
                        }
                    }
                    .padding(.vertical, isIPad ? 50 : 20)
                    .background(.white)
                    
                    VStack(spacing: isIPad ? 20 : 10) {
                        Text("Share what's on your mind")
                            .font(.custom("AvenirNext-Bold", size: isIPad ? 40 : 24))
                            .foregroundColor(Color("CoralMood"))
                            .padding(.bottom, 10)
                        
                        ZStack(alignment: .topLeading) {
                                
                                RoundedRectangle(cornerRadius:  isIPad ? 25 : 20)
                                .fill(Color.whiteMood)
                                    .stroke(Color("CoralMood"), lineWidth:  isIPad ? 5 :  4)
                                
                                TextEditor(text: $userThought)
                                    .scrollContentBackground(.hidden)
                                    .background(Color.clear)
                                    .foregroundColor(Color("BlueMood"))
                                    .padding( isIPad ? 20 : 10)
                            }
                            .frame(height: isIPad ? 150 : 100)
                    }
                    .padding(.horizontal, isIPad ? 50 : 30)
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
