//
//  WelcomeViewModel.swift
//  MoodMate
//
//  Created by Gis Cam on 29/11/25.
//

import Foundation
import Observation

@MainActor
@Observable
final class WelcomeViewModel {

    var didTapLogin: Bool = false
    var didTapSignUp: Bool = false

    func loginTapped() {
        didTapLogin = true
    }

    func signUpTapped() {
        didTapSignUp = true
    }

    var screenName: String = "Welcome"
}
