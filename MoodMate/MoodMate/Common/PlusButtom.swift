//
//  PlusButtom.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct PlusButton: View {
    let backgroundColor: String
    let action: () -> Void
    let size: CGFloat
    let padding: CGFloat
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: size, weight: .bold))
                .foregroundColor(.white)
                .padding(padding)
                .background(Color(backgroundColor))
                .clipShape(Circle())
                .shadow(radius: 5)
                .padding(.top, 5)
        }
    }
}
