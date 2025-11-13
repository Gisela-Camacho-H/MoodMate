//
//  LoginView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import FBSDKLoginKit

struct LoginView: View {
    @State private var email = ""
    @State private var password: String = ""
    
    @Environment(\.dismiss) var dismiss
    @Environment(AuthController.self) private var authController
    
    @State private var loginError: String?
    @State private var showingAlert = false
    
    private var cardShadow: Color {
        Color("SpaceMood")
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Text("Sign In")
                        .font(.custom("AvenirNext-Bold", size: 45))
                        .fontDesign(.rounded)
                        .foregroundColor(Color("CoralMood"))
                    
                    VStack(spacing: 30) {
                        VStack(spacing: 30) {
                            TextField("Email", text: $email)
                                .modifier(TextFieldMoodMate(iconName: "envelope.fill"))
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .foregroundColor(.primary)
                            
                            SecureField("Password", text: $password)
                                .modifier(TextFieldMoodMate(iconName: "key.horizontal.fill"))
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.vertical, 30)
                    .frame(width: geometry.size.width * 0.9)
                    .background(Color("SpaceMood"))
                    .cornerRadius(20)
                    .shadow(color: cardShadow.opacity(0.3), radius: 10, x: 0, y: 5)
                    .shadow(color: Color.shadowMood.opacity(0.15), radius: 5, x: 0, y: 5)
                    

                    Button(action: {
                        signInWithEmailPassword()
                    }) {
                        Text("Login")
                            .font(.custom("AvenirNext-Bold", size: 32))
                                .foregroundColor(.white)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity)
                                .background(Color("BlueMood"))
                                .cornerRadius(20)
                                .shadow(color: Color.shadowMood.opacity(0.15), radius: 5, x: 0, y: 5)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top)
                    
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Login Error"),
                            message: Text(loginError ?? "Unknown error"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .padding(.top, 10)
                    
                    VStack(spacing: 20) {
                        Text("or sign in with")
                            .font(.custom("AvenirNext-Bold", size: 15))
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 40) {
                            Button(action: {
                                signInGoogle()
                            }) {
                                Image("GoogleIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .clipShape(Rectangle())
                                    .shadow(color: Color.shadowMood.opacity(0.4), radius: 10, x: 0, y: 10)
                            }
                            
                            Button(action: {
                                signInFacebook()
                            }) {
                                Image("FacebookIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .clipShape(Rectangle())
                                    .shadow(color: Color.shadowMood.opacity(0.4), radius: 10, x: 0, y: 10)
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    
                    Spacer()
                    
                    NavigationTextLink(
                        messageText: "Don't have an account?",
                        linkText: "Sign up",
                        destination: SignUpView()
                    )
                }
                .padding(.bottom, 20)
            }
            .navigationBarHidden(true)
            .padding(.top, 100)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BaseMood"))
        }
    }
    
    @MainActor
    func signInWithEmailPassword() {
        Task {
            do {
                try await authController.signInWithEmail(email: email, password: password)
                print("✅ Login con email y contraseña exitoso")
            } catch {
                print("Error de Sign-In con Firebase: \(error.localizedDescription)")
                loginError = error.localizedDescription
                showingAlert = true
            }
        }
    }
    
    @MainActor
    func signInGoogle() {
        Task {
            do {
                try await authController.signIn()
            } catch {
                print("Error de Sign-In con Google: \(error.localizedDescription)")
            }
        }
    }
    
    @MainActor
    func signInFacebook() {
        Task {
            do {
                try await authController.signInWithFacebook()
            } catch {
                print("Error de Sign-In con Facebook: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    LoginView()
        .environment(AuthController())
}
