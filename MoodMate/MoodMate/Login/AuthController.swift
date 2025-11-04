//
//  AuthController.swift
//  MoodMate
//
//  Created by Gis Cam on 01/11/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import FBSDKLoginKit

@Observable
final class AuthController {
    var authState: AuthState = .undefined

    init() {}

    func startListeningToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.authState = user != nil ? .authenticated : .notAuthenticated
            print("AUTH STATE CHANGED: \(self?.authState ?? .undefined)")
        }
    }

    @MainActor
    func signInWithEmail(email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
    }

    @MainActor
    func signUpWithEmail(email: String, password: String, name: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = result.user

        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = name
        try await changeRequest.commitChanges()
    }
    
    @MainActor
    func signIn() async throws {
        guard let rootViewController = UIApplication.shared.firstKeyWindow?.rootViewController else {
            throw NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can't get controller in root"])
        }
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw NSError(domain: "AuthError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Firebase client ID"])
        }

        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration

        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)

        guard let idToken = result.user.idToken?.tokenString else {
            throw NSError(domain: "AuthError", code: 2, userInfo: [NSLocalizedDescriptionKey: "No ID from Google"])
        }
        let accessToken = result.user.accessToken.tokenString

        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        try await Auth.auth().signIn(with: credential)
    }

    @MainActor
    func signInWithFacebook() async throws {
        guard let rootViewController = UIApplication.shared.firstKeyWindow?.rootViewController else {
            throw NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can't get controller in root"])
        }

        let loginManager = LoginManager()

        let loginResult: Result<LoginManagerLoginResult, Error> = await withCheckedContinuation { continuation in
            loginManager.logIn(permissions: ["public_profile", "email"], from: rootViewController) { result, error in
                if let result = result, !result.isCancelled {
                    continuation.resume(returning: .success(result))
                } else if let error = error {
                    continuation.resume(throwing: error as! Never)
                } else {
                    let cancelledError = NSError(
                        domain: "AuthError",
                        code: 3,
                        userInfo: [NSLocalizedDescriptionKey: "Inicio de sesión de Facebook cancelado."]
                    )
                    continuation.resume(throwing: cancelledError as! Never)
                }
            }
        }

        switch loginResult {
        case .success(let result):
            guard let token = result.token else {
                throw NSError(domain: "AuthError", code: 4, userInfo: [NSLocalizedDescriptionKey: "No se recibió el token de Facebook."])
            }

            let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
            let authResult = try await Auth.auth().signIn(with: credential)
            let user = authResult.user

            let profileData = try await fetchFacebookProfile(token: token, includeEmail: true)

            let changeRequest = user.createProfileChangeRequest()
            if let name = profileData.name {
                changeRequest.displayName = name
            }
            if let photoURL = profileData.photoURL {
                changeRequest.photoURL = photoURL
            }

            try await changeRequest.commitChanges()

            if let email = profileData.email, user.email == nil {
                try await user.updateEmail(to: email)
            }

            try await user.reload()

        case .failure(let error):
            throw error
        }
    }

    struct FacebookProfileData {
        let name: String?
        let email: String?
        let photoURL: URL?

        init?(json: [String: Any]) {
            self.name = json["name"] as? String
            self.email = json["email"] as? String

            if let pictureDict = json["picture"] as? [String: Any],
               let dataDict = pictureDict["data"] as? [String: Any],
               let urlString = dataDict["url"] as? String {
                self.photoURL = URL(string: urlString)
            } else {
                self.photoURL = nil
            }
        }
    }

    private func fetchFacebookProfile(token: AccessToken, includeEmail: Bool) async throws -> FacebookProfileData {
        return try await withCheckedThrowingContinuation { continuation in
            var fields = "name,picture.width(500).height(500)"
            if includeEmail { fields += ",email" }

            let parameters = ["fields": fields]
            let request = GraphRequest(graphPath: "me", parameters: parameters, tokenString: token.tokenString, version: nil, httpMethod: .get)

            request.start { _, result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let json = result as? [String: Any],
                      let profileData = FacebookProfileData(json: json) else {
                    let parseError = NSError(domain: "FacebookAPI", code: 5, userInfo: [NSLocalizedDescriptionKey: "Failed to parse Facebook data."])
                    continuation.resume(throwing: parseError)
                    return
                }

                continuation.resume(returning: profileData)
            }
        }
    }

    @MainActor
    func signOut() throws {
        try Auth.auth().signOut()
        GIDSignIn.sharedInstance.signOut()
        LoginManager().logOut()
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?.windows
            .first(where: \.isKeyWindow)
    }
}
