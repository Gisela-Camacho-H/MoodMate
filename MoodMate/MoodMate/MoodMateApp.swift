//
//  MoodMateApp.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI
import FirebaseCore

@main
struct MoodMateApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var authController = AuthController()

    var body: some Scene {
        WindowGroup {
            Group {
                switch authController.authState {

                case .authenticated:
                    MainTabView()

                case .notAuthenticated:
                    NavigationStack {
                        WelcomeView()
                    }

                case .undefined:
                    ProgressView()
                }
            }
            .environmentObject(authController)     // 🔥 Correct
        }
    }
}
