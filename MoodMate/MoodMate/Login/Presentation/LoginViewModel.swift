//
//  LoginViewModel.swift
//  MoodMate
//
//  Created by Gis Cam on 29/11/25.
//

import Foundation
import Observation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var showingAlert: Bool = false

    private let authService = FirebaseAuthService.shared

    // MARK: Email/Password Sign In
    func signIn() async {
        do {
            try await authService.signInWithEmail(email: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
            showingAlert = true
        }
    }

    func signInWithGoogle() async {
        do {
            try await authService.signInWithGoogle()
        } catch {
            errorMessage = error.localizedDescription
            showingAlert = true
        }
    }

    // MARK: Facebook Sign In
    func signInWithFacebook() async {
        do {
            try await authService.signInWithFacebook()
        } catch {
            errorMessage = error.localizedDescription
            showingAlert = true
        }
    }
}
