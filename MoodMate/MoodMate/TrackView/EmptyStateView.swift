//
//  EmptyStateView.swift
//  MoodMate
//
//  Created by Gis Cam on 07/11/25.
//

import SwiftUI

struct EmptyStateView: View {
    var onAddMood: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            Image("Empty")
                .resizable()
                .frame(width: 200, height: 200)
            
            Text("No moods yet")
                .font(.custom("AvenirNext-Bold", size: 24))
                .foregroundColor(.gray)
            
            Text("Start tracking your moods today! Tap below to add your first mood.")
                .font(.custom("AvenirNext-Regular", size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button(action: onAddMood) {
                Text("Add Mood")
                    .font(.custom("AvenirNext-Bold", size: 25))
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300)
                    .background(Color("BlueMood"))
                    .cornerRadius(20)
                    .shadow(color: Color.shadowMood.opacity(0.15), radius: 5, x: 0, y: 5)
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 50)
    }
}
