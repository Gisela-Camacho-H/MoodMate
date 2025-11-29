//
//  LoginView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI
import GoogleSignIn
import FBSDKLoginKit

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel() // Owns the ViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private var isIPad: Bool { horizontalSizeClass == .regular }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    // MARK: Title
                    Text("Sign In")
                        .font(.custom("AvenirNext-Bold", size: isIPad ? 55 : 45))
                        .fontDesign(.rounded)
                        .foregroundColor(Color("CoralMood"))
                        .padding(.bottom, isIPad ? 60 : 0)
                    
                    // MARK: Email & Password Fields
                    VStack(spacing: isIPad ? 55 : 30) {
                        TextField("Email", text: $viewModel.email)
                            .modifier(TextFieldMoodMate(iconName: "envelope.fill"))
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .foregroundColor(.primary)
                        
                        SecureField("Password", text: $viewModel.password)
                            .modifier(TextFieldMoodMate(iconName: "key.horizontal.fill"))
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal, isIPad ? 50 : 20)
                    .padding(.vertical,isIPad ? 55 : 30)
                    .frame(width: geometry.size.width * 0.9)
                    .background(Color("SpaceMood"))
                    .cornerRadius(isIPad ? 30 : 20)
                    .shadow(color: Color("SpaceMood").opacity(0.3), radius: 10, x: 0, y: 5)
                    .shadow(color: Color.shadowMood.opacity(0.15), radius: 10, x: 0, y: 10)
                    
                    // MARK: Login Button
                    Button(action: {
                        Task { await viewModel.signIn() }
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
                    .padding(.top,isIPad ? 60 : 10)
                    
                    // MARK: Social Login
                    VStack(spacing:isIPad ? 40 : 20) {
                        Text("or sign in with")
                            .font(.custom("AvenirNext-Bold", size: isIPad ? 25 : 15))
                            .foregroundColor(.gray)
                        
                        HStack(spacing: isIPad ? 60 : 40) {
                            // Google Button
                            Button(action: { Task { await viewModel.signInWithGoogle() } }) {
                                Image("GoogleIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: isIPad ? 80 : 45, height: isIPad ? 80 : 45)
                                    .clipShape(Rectangle())
                                    .shadow(color: Color.shadowMood.opacity(0.4), radius: 10, x: 0, y: 10)
                            }
                            
                            // Facebook Button
                            Button(action: { Task { await viewModel.signInWithFacebook() } }) {
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
                    
                    // MARK: Navigation to SignUp
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
}

#Preview {
    LoginView()
}
