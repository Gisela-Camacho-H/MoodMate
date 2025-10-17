//
//  WelcomeView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("BlueBackground")
                    .ignoresSafeArea()
                VStack {
                    Image("Name")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .padding(.trailing, 15)
                    
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 190, height: 190)
                        .padding(.top, 100)
                        .padding(.bottom, 180)
                    
                    NavigationButton(title: "Login", destination: ContentView())
                    
                    NavigationTextLink(
                        messageText: "Don't have an account?",
                        linkText: "Sign up",
                        destination: ContentView())
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
