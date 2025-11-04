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
        Color(.white)
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
                            
                            TextField("Email", text: $email)
                                .modifier(TextFieldMoodMate(iconName: "envelope.fill"))
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                            
                            SecureField("Password", text: $password)
                                .modifier(TextFieldMoodMate(iconName: "key.horizontal.fill"))
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.vertical, 30)
                    .frame(width: geometry.size.width * 0.9)
                    .background(.white)
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("BlueMood"), lineWidth: 2))
                    .shadow(color: cardShadow.opacity(0.3), radius: 10, x:0, y: 5)
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x:0, y: 5)
                    
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
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
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
            .background(.white)
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
