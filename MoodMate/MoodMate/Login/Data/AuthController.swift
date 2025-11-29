//
//  AuthController.swift
//  MoodMate
//
//  Created by Gis Cam on 01/11/25.
//

import SwiftUI
import Combine
import FirebaseAuth

@MainActor
class AuthController: ObservableObject {

    @Published var authState: AuthState = .undefined
    @Published var firebaseUser: FirebaseAuth.User? = nil

    init() {
        startListeningToAuthState()
    }

    func startListeningToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }

            Task { @MainActor in
                self.firebaseUser = user
                self.authState = user != nil ? .authenticated : .notAuthenticated
            }
        }
    }

    func signUpWithEmail(email: String, password: String, name: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        firebaseUser = result.user

        let changeRequest = result.user.createProfileChangeRequest()
        changeRequest.displayName = name
        try await changeRequest.commitChanges()
    }

    func login(email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        firebaseUser = result.user
    }

    func signOut() throws {
        try Auth.auth().signOut()
        firebaseUser = nil
        authState = .notAuthenticated
    }
}
