//
//  PlusButtom.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct PlusButton<Destination: View>: View {
    let backgroundColor: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
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
