//
//  EmptyStateView.swift
//  MoodMate
//
//  Created by Gis Cam on 07/11/25.
//

import SwiftUI

struct EmptyStateView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
    var onAddMood: () -> Void
    
    var body: some View {
        VStack(spacing: isIPad ? 50 : 40) {
            Image("Empty")
                .resizable()
                .frame(width: isIPad ? 350 : 200, height: isIPad ? 350 : 200)
            
            Text("No moods yet")
                .font(.custom("AvenirNext-Bold", size: isIPad ? 40 : 24))
                .foregroundColor(.gray)
            
            Text("Start tracking your moods today! Tap below to add your first mood.")
                .font(.custom("AvenirNext-Regular", size: isIPad ? 26 : 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, isIPad ? 60 : 40)
            
            Button(action: onAddMood) {
                Text("Add Mood")
                    .font(.custom("AvenirNext-Bold", size: isIPad ? 40 : 25))
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: isIPad ? 350 : 300)
                    .background(Color("BlueMood"))
                    .cornerRadius(20)
                    .shadow(color: Color.shadowMood.opacity(0.15), radius: 10, x: 0, y: 10)
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 50)
    }
}
