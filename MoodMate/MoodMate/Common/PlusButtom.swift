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
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .padding(15)
                .background(Color(backgroundColor))
                .clipShape(Circle())
                .shadow(radius: 5)
                .padding(.top, 5)
        }
    }
}
