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
                    Label("Home", systemImage: "house")
                }
            MoodView()
                .tabItem {
                    Label("Mood", systemImage: "apple.meditate")
                }
            EmotionsView()
                .tabItem {
                    Label("Emotions", systemImage: "face.smiling")
                }
            TrackView()
                .tabItem {
                    Label("Track", systemImage: "list.bullet")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .accentColor(Color("BlueMood"))
    }
}

#Preview {
    MainTabView()
}
