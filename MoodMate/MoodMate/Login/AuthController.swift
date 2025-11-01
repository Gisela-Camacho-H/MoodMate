//
//  AuthController.swift
//  MoodMate
//
//  Created by Gis Cam on 01/11/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

@Observable
final class AuthController {
    
    var authState: AuthState = .undefined
    
    init() {
    }

    func startListeningToAuthState() {

        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.authState = user != nil ? .authenticated : .notAuthenticated
            print("AUTH STATE CHANGED: \(self?.authState ?? .undefined)")
        }
    }
    
    @MainActor
    func signIn() async throws {
        
    
        guard let rootViewController = UIApplication.shared.firstKeyWindow?.rootViewController else {
            throw NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can't get controller in root"])
        }
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw NSError(domain: "AuthError", code: 1, userInfo: [NSLocalizedDescriptionKey: "no Id firebase client"])
        }
          
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration
 
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
          
        guard let idToken = result.user.idToken?.tokenString else {
            throw NSError(domain: "AuthError", code: 2, userInfo: [NSLocalizedDescriptionKey: "no Id from Google."])
        }
        let accessToken = result.user.accessToken.tokenString
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        try await Auth.auth().signIn(with: credential)
    }
    
    @MainActor
    func signOut() throws {
        try Auth.auth().signOut()
        GIDSignIn.sharedInstance.signOut()
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap {$0 as? UIWindowScene}
            .filter { $0.activationState == .foregroundActive}
            .first?.windows
            .first(where: \.isKeyWindow)
    }
}
