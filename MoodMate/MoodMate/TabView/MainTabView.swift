//
//  MainTabView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var tabManager = TabMaganer()
    var body: some View {
        TabView(selection: $tabManager.selectionTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(TabSelection.home)
            MoodView()
                .tabItem {
                    Label("Mood", systemImage: "apple.meditate")
                }
                .tag(TabSelection.mood)
            EmotionsView()
                .tabItem {
                    Label("Emotions", systemImage: "face.smiling")
                }
                .tag(TabSelection.emotions)
            TrackView()
                .tabItem {
                    Label("Track", systemImage: "list.bullet")
                }
                .tag(TabSelection.track)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(TabSelection.profile)
        }
        .accentColor(Color("BlueMood"))
        .navigationBarHidden(true)
    }
}

#Preview {
    MainTabView()
}
