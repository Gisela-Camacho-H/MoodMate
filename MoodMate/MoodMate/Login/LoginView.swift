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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
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
                        .font(.custom("AvenirNext-Bold", size: isIPad ? 55 : 45))
                        .fontDesign(.rounded)
                        .foregroundColor(Color("CoralMood"))
                        .padding(.bottom, isIPad ? 60 : 0)
                    
                    VStack(spacing: isIPad ? 55 : 30) {
                        VStack(spacing: isIPad ? 55 : 30) {
                            TextField("Email", text: $email)
                                .modifier(TextFieldMoodMate(iconName: "envelope.fill"))
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .foregroundColor(.primary)
                            
                            SecureField("Password", text: $password)
                                .modifier(TextFieldMoodMate(iconName: "key.horizontal.fill"))
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal, isIPad ? 50 : 20)
                    }
                    .padding(.vertical,isIPad ? 55 : 30)
                    .frame(width: geometry.size.width * 0.9)
                    .background(Color("SpaceMood"))
                    .cornerRadius(isIPad ? 30 : 20)
                    .shadow(color: cardShadow.opacity(0.3), radius: 10, x: 0, y: 5)
                    .shadow(color: Color.shadowMood.opacity(0.15), radius: 10, x: 0, y: 10)
                    

                    Button(action: {
                        signInWithEmailPassword()
                    }) {
                        Text("Login")
                            .font(.custom("AvenirNext-Bold", size: isIPad ? 40 :32))
                                .foregroundColor(.white)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity)
                                .background(Color("BlueMood"))
                                .cornerRadius(20)
                                .shadow(color: Color.shadowMood.opacity(0.15), radius: 10, x: 0, y: 10)
                    }
                    .padding(.horizontal, isIPad ? 60 : 40)
                    .padding(.top)
                    
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Login Error"),
                            message: Text(loginError ?? "Unknown error"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .padding(.top,isIPad ? 60 : 10)
                    
                    VStack(spacing:isIPad ? 40 : 20) {
                        Text("or sign in with")
                            .font(.custom("AvenirNext-Bold", size: isIPad ? 25 : 15))
                            .foregroundColor(.gray)
                        
                        HStack(spacing: isIPad ? 60 : 40) {
                            Button(action: {
                                signInGoogle()
                            }) {
                                Image("GoogleIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: isIPad ? 80 : 45, height: isIPad ? 80 : 45)
                                    .clipShape(Rectangle())
                                    .shadow(color: Color.shadowMood.opacity(0.4), radius: 10, x: 0, y: 10)
                            }
                            
                            Button(action: {
                                signInFacebook()
                            }) {
                                Image("FacebookIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: isIPad ? 80 : 45, height: isIPad ? 80 : 45)
                                    .clipShape(Rectangle())
                                    .shadow(color: Color.shadowMood.opacity(0.4), radius: 10, x: 0, y: 10)
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.top, isIPad ? 60 : 0)
                    
                    Spacer()
                    
                    NavigationTextLink(
                        messageText: "Don't have an account?",
                        linkText: "Sign up",
                        destination: SignUpView()
                    )
                }
                .padding(.bottom, isIPad ? 40 : 20)
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
