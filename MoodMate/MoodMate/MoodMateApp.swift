//
//  MoodMateApp.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


@main
struct MoodMateApp: App {
    

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    

    @State private var authController = AuthController()

    
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

            .environment(authController)

            .onAppear {
                authController.startListeningToAuthState()
            }
        }
    }
}
