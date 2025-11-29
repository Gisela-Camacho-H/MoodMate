//
//  AuthRepositoryProtocol.swift
//  MoodMate
//
//  Created by Gis Cam on 29/11/25.
//

import Foundation

protocol AuthRepositoryProtocol {
    var authState: AuthState { get }
    func startListeningToAuthState()
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String, name: String) async throws
    func signInWithGoogle() async throws
    func signInWithFacebook() async throws
    func signOut() throws
}
