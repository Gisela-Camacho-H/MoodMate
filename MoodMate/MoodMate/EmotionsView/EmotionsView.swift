//
//  EmotionsView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct EmotionsView: View {
    
    let emotions = EmotionModel.emotionList
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
    var body: some View {
        
        ZStack {
            Color("BaseMood").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Emotions View")
                    .font(.custom("AvenirNext-Bold", size: isIPad ? 50 : 45))
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
                                    .frame(width:  isIPad ? 90 : 65, height:  isIPad ? 90 : 65)
                                    .padding(.trailing,  isIPad ? 30 : 15)
                                
                                VStack(alignment: .leading) {
                                    Text(emotion.name)
                                        .font(.custom("AvenirNext-DemiBold", size:  isIPad ? 35 : 25))
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
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("BlueMood"), lineWidth: 2)
                )
                .padding(.horizontal,  isIPad ? 50 : 30)
                .shadow(color: Color("BlueMood").opacity(0.3), radius: 10, x: 0, y: 5)
                .shadow(color: Color.shadowMood.opacity(0.3), radius: 10, x: 0, y: 10)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    EmotionsView()
}
