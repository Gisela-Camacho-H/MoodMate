//
//  EmotionsView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct EmotionsView: View {
    
    let emotions = EmotionModel.emotionList
    
    var body: some View {
        
        ZStack {
            Color("BaseMood").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Emotions View")
                    .font(.custom("AvenirNext-Bold", size: 45))
                    .foregroundColor(Color("CoralMood"))
                    .padding([.horizontal, .top], 30)
                    .padding(.bottom, 15)
                
                List {
                    ForEach(emotions) { emotion in
                        
                        NavigationLink(destination: DescriptionView(emotion: emotion)) {
                            HStack {
                                Image(emotion.iconName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 65, height: 65)
                                    .padding(.trailing, 15)
                                
                                VStack(alignment: .leading) {
                                    Text(emotion.name)
                                        .font(.custom("AvenirNext-DemiBold", size: 25))
                                        .foregroundColor(Color("GrayMood"))
                                
                                }
                            }
                        }
                        .listRowBackground(Color.white)
                    }
                }
                .listStyle(.plain)
                .background(Color.clear)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BlueMood"), lineWidth: 2)
                )
                .padding(.horizontal)
                .shadow(color: Color("BlueMood").opacity(0.3), radius: 10, x: 0, y: 5)
                .shadow(color: Color.shadowMood.opacity(0.3), radius: 5, x: 0, y: 5)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    EmotionsView()
}
