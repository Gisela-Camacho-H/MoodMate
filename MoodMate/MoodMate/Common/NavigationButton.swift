//
//  NavigationButton.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct NavigationButton<Destination: View>: View {
    let title: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .font(.custom("AvenirNext-Bold", size: 32))
                .foregroundColor(.white)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity)
                .background(Color("BlueMood"))
                .cornerRadius(20)
                .shadow(color: Color.shadowMood.opacity(0.15), radius: 5, x: 0, y: 5)
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 20)
    }
}
