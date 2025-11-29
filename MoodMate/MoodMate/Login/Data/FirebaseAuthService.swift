//
//  FirebaseAuthService.swift
//  MoodMate
//
//  Created by Gis Cam on 29/11/25.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import FBSDKLoginKit
import UIKit


@MainActor
public final class FirebaseAuthService: ObservableObject {

    @Published public var authState: AuthState = .undefined

    public static let shared = FirebaseAuthService()

    private var authListenerHandle: AuthStateDidChangeListenerHandle?

    private init() {}

    deinit {
        if let handle = authListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    public func startListeningToAuthState() {
        if let handle = authListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
            authListenerHandle = nil
        }

        authListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.authState = (user != nil) ? .authenticated : .notAuthenticated
            }
        }
    }

    public func signInWithEmail(email: String, password: String) async throws {
        _ = try await Auth.auth().signIn(withEmail: email, password: password)
    }

    // MARK: Email sign-up
    public func signUpWithEmail(email: String, password: String, name: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = result.user
        let change = user.createProfileChangeRequest()
        change.displayName = name
        try await change.commitChanges()
    }

    
    public func signInWithGoogle() async throws {
        guard let rootVC = UIApplication.shared.firstKeyWindow?.rootViewController else { return }

        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootVC)

        guard let idToken = result.user.idToken?.tokenString else { return }

        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: result.user.accessToken.tokenString
        )

        _ = try await Auth.auth().signIn(with: credential)
    }

    public func signInWithFacebook() async throws {
        guard let rootVC = UIApplication.shared.firstKeyWindow?.rootViewController else { return }

        let manager = LoginManager()

        let result: LoginManagerLoginResult = try await withCheckedThrowingContinuation { continuation in
            manager.logIn(permissions: ["public_profile"], from: rootVC) { res, err in
                if let err = err {
                    continuation.resume(throwing: err)
                } else if let res = res, !res.isCancelled {
                    continuation.resume(returning: res)
                } else {
                    continuation.resume(throwing: NSError(domain: "AuthError", code: -1))
                }
            }
        }

        guard let token = result.token else { return }

        let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)

        _ = try await Auth.auth().signIn(with: credential)
    }

    // MARK: Logout
    public func signOut() throws {
        try Auth.auth().signOut()
        GIDSignIn.sharedInstance.signOut()
        LoginManager().logOut()
        authState = .notAuthenticated
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
    }
}
