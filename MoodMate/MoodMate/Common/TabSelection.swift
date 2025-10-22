//
//  TabSelection.swift
//  MoodMate
//
//  Created by Gis Cam on 22/10/25.
//

import SwiftUI
import Combine

enum TabSelection: String {
    case home = "Home"
    case mood = "Mood"
    case emotions = "Emotions"
    case track = "Track"
    case profile = "Profile"
}

class TabManager: ObservableObject {
    @Published var selectionTab: TabSelection = .home
}
