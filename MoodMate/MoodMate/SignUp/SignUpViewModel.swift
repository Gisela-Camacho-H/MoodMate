//
//  SignUpViewModel.swift
//  MoodMate
//
//  Created by Gis Cam on 04/12/25.
//

import Foundation
import Combine

@MainActor
final class SignUpViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var errorMessage: String = ""

    private let authService = FirebaseAuthService.shared

    func signUp() async {
        do {
            try await authService.signUpWithEmail(
                email: email,
                password: password,
                name: name
            )
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
