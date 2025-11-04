//
//  AppDelegate.swift
//  MoodMate
//
//  Created by Gis Cam on 01/11/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        FirebaseApp.configure()
        
        ApplicationDelegate.shared.application(application,
                                              didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        

        let handledByGoogle = GIDSignIn.sharedInstance.handle(url)
        if handledByGoogle {
            return true
        }
        
 
        let handledByFacebook = ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        

        return handledByFacebook
    }
}
