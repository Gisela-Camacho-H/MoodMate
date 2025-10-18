//
//  MainTabView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            MoodView()
                .tabItem {
                    Label("Mood", systemImage: "heart.square.fill")
                }
            EmotionsView()
                .tabItem {
                    Label("Emotions", systemImage: "face.smiling")
                }
            TrackView()
                .tabItem {
                    Label("Track", systemImage: "list.bullet.clipboard.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
        }
        .accentColor(Color("BlueMood"))
    }
}

#Preview {
    MainTabView()
}
