//
//  HomeView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
                VStack(spacing:20) {
                    Image("Banner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .padding(.top, -166)
                    
                    Text("Emotions are part of God's design \nlistening to them is a strength")
                        .font(.custom("AvenirNext-Bold", size: 20))
                        .foregroundColor(Color("BlueMood"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    NavigationButton(title: "Log my mood", destination: WelcomeView())
                    
                    PlusButton(backgroundColor: "CoralMood", destination: WelcomeView())
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Quote of the day:")
                            .font(.custom("AvenirNext-Bold", size: 20))
                            .foregroundColor(Color("GreenMood"))
                            .padding(.horizontal)
                        
                        QuoteCardView(
                            quote: "If you can dream it, you can do it.",
                            author: "Walt Disney")
                    }
                }
            }
        }

#Preview {
    HomeView()
}
