//
//  DescriptionView.swift
//  MoodMate
//
//  Created by Gis Cam on 22/10/25.
//

import SwiftUI

struct DescriptionView: View {
    
    @Environment(\.dismiss) var dismiss
    let emotion: EmotionModel
    
    @StateObject private var viewModel: DescriptionViewModel
    
    init(emotion: EmotionModel) {
        self.emotion = emotion
        _viewModel = StateObject(wrappedValue: DescriptionViewModel(emotionName: emotion.name))
    }
    
    var body: some View {
        ZStack {
            Color("BaseMood").edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                 Text("Emotion Description")
                    .font(.custom("AvenirNext-Bold", size: 36))
                    .foregroundColor(Color("CoralMood"))
                    .padding(.top, 30)
                
                Image(emotion.iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                
                Text(emotion.name)
                    .font(.custom("AvenirNext-Bold", size: 40))
                    .foregroundColor(Color("BlueMood"))
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    if viewModel.isLoading {
                        ProgressView("Loading ...")
                            .padding(50)
                    } else if let description = viewModel.descriptionText {
                        Text(description)
                            .font(.custom("AvenirNext-Bold", size: 20))
                            .foregroundColor(Color("BlueMood"))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                    } else {
                        Text("This is a state of inner peace and stillness. You feel relaxed, unhurried, and mentally quiet, like the surface of a clear lake. There are no pressing worries, and you feel comfortable simply being in the moment.")
                            .font(.custom("AvenirNext-Bold", size: 20))
                            .foregroundColor(Color("BlueMood"))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(25)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("CoralMood"), lineWidth: 1.5)
                )
                .padding(.horizontal, 30)
                
                HStack {
                    Button(action: { dismiss()})
                    {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color("CoralMood"))
                            .clipShape(Circle())
                            .shadow(color: .shadowMood.opacity(0.3), radius: 10, x: 0, y: 10)
                    }
                    .padding(.top, 5)
                    Spacer()
                }
                .padding(.leading, 20)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    DescriptionView(emotion: EmotionModel.emotionList[0])
}
