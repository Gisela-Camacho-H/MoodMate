//
//  MoodView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct MoodView: View {
    var body: some View {
        Text("Mood View")
            .font(.custom("AvenirNext-Bold", size: 45))
            .fontDesign(.rounded)
            .foregroundColor(Color("CoralMood"))
    }
}

#Preview {
    MoodView()
}
