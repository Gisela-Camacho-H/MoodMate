//
//  SignUpView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @State private var email = ""
    @State private var password: String = ""
    @State private var name: String = ""
    
    @State private var signUpError: String?
    @State private var showingAlert = false
    
    @Environment(AuthController.self) private var authController
    
    private var cardShadow: Color {
        Color("SpaceMood")
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Text("Create Account")
                        .font(.custom("AvenirNext-Bold", size: 45))
                        .fontDesign(.rounded)
                        .foregroundColor(Color("CoralMood"))
                    
                    VStack(spacing: 30) {
                        VStack(spacing: 30) {
                            TextField("Name", text: $name)
                                .modifier(TextFieldMoodMate(iconName: "person.fill"))
                                .foregroundColor(.primary)
                            
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
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("BlueMood"), lineWidth: 2))
                    .cornerRadius(20)
                    .shadow(color: cardShadow.opacity(0.3), radius: 10, x:0, y: 5)
                    .shadow(color: Color.shadowMood.opacity(0.15), radius: 10, x:0, y: 10)
                    
                    Button(action: {
                        signUpUser()
                    }) {
                        Text("Submit")
                            .font(.custom("AvenirNext-Bold", size: 32))
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .frame(maxWidth: .infinity)
                            .background(Color("BlueMood"))
                            .cornerRadius(15)
                            .shadow(color: Color.shadowMood.opacity(0.15), radius: 10, x: 0, y: 10)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Sign Up Error"),
                            message: Text(signUpError ?? "Unknown error"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    NavigationTextLink(
                        messageText: "Already have an account?",
                        linkText: "Login",
                        destination: LoginView())
                }
                .padding(.bottom, 20)
            }
            .padding(.top, 100)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.spaceMood)
        }
    }
    
    @MainActor
    func signUpUser() {
        Task {
            do {
                try await authController.signUpWithEmail(email: email, password: password, name: name)
                print("✅ Usuario creado correctamente")
            } catch {
                print("Error al crear usuario: \(error.localizedDescription)")
                signUpError = error.localizedDescription
                showingAlert = true
            }
        }
    }
}

#Preview {
    SignUpView()
        .environment(AuthController())
}
