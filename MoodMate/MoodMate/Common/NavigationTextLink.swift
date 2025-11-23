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
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
    var body: some View {
        HStack(spacing: isIPad ? 20 : 10) {
            Text(messageText)
                .font(.custom("AvenirNext-Bold", size: isIPad ? 30 : 20))
                .foregroundColor(Color("GrayMood"))
            NavigationLink(destination: destination) {
                Text(linkText)
                    .font(.custom("AvenirNext-Bold", size: isIPad ? 30 : 20))
                    .foregroundColor(Color("CoralMood"))
            }
        }
    }
}
