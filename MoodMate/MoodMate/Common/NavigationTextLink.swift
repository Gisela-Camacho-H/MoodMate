//
//  NavigationTextLink.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct NavigationTextLink<Destination: View>: View {
    let messageText: String
    let linkText: String
    let destination: Destination
    
    var body: some View {
        HStack(spacing: 10) {
            Text(messageText)
                .font(.custom("AvenirNext-Bold", size: 20))
                .foregroundColor(Color("GrayMood"))
            NavigationLink(destination: destination) {
                Text(linkText)
                    .font(.custom("AvenirNext-Bold", size: 20))
                    .foregroundColor(Color("CoralMood"))
            }
        }
    }
}
