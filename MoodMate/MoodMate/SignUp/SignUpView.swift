//
//  SignUpView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct SignUpView: View {

    @StateObject private var viewModel = SignUpViewModel()

    @State private var showingAlert = false

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }

    private var cardShadow: Color {
        Color("SpaceMood")
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Text("Create Account")
                        .font(.custom("AvenirNext-Bold", size: isIPad ? 60 : 45))
                        .fontDesign(.rounded)
                        .foregroundColor(Color("CoralMood"))

                    VStack(spacing: isIPad ? 60 : 30) {
                        VStack(spacing: isIPad ? 60 : 30) {

                            TextField("Name", text: $viewModel.name)
                                .modifier(TextFieldMoodMate(iconName: "person.fill"))
                                .foregroundColor(.primary)

                            TextField("Email", text: $viewModel.email)
                                .modifier(TextFieldMoodMate(iconName: "envelope.fill"))
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .foregroundColor(.primary)

                            SecureField("Password", text: $viewModel.password)
                                .modifier(TextFieldMoodMate(iconName: "key.horizontal.fill"))
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal, isIPad ? 40 : 20)
                    }
                    .padding(.vertical, isIPad ? 60 : 30)
                    .frame(width: geometry.size.width * 0.9)
                    .background(Color("SpaceMood"))
                    .overlay(
                        RoundedRectangle(cornerRadius: isIPad ? 40 : 20)
                            .stroke(Color("BlueMood"), lineWidth: isIPad ? 4 : 2)
                    )
                    .cornerRadius(isIPad ? 40 : 20)
                    .shadow(color: cardShadow.opacity(0.3), radius: 10, x: 0, y: 5)
                    .shadow(color: Color.shadowMood.opacity(0.15), radius: 10, x: 0, y: 10)

                    Button(action: {
                        Task {
                            await viewModel.signUp()

                            if !viewModel.errorMessage.isEmpty {
                                showingAlert = true
                            }
                        }
                    }) {
                        Text("Submit")
                            .font(.custom("AvenirNext-Bold", size: isIPad ? 40 : 32))
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .frame(maxWidth: .infinity)
                            .background(Color("BlueMood"))
                            .cornerRadius(15)
                            .shadow(color: Color.shadowMood.opacity(0.15),
                                    radius: 10, x: 0, y: 10)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Sign Up Error"),
                            message: Text(viewModel.errorMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .padding(.horizontal, isIPad ? 60 : 40)
                    .padding(.top, isIPad ? 40 : 10)

                    Spacer()

                    NavigationTextLink(
                        messageText: "Already have an account?",
                        linkText: "Login",
                        destination: LoginView()
                    )
                }
                .padding(.bottom, isIPad ? 40 : 20)
            }
            .padding(.top, 100)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.spaceMood)
        }
    }
}

#Preview {
    SignUpView()
}
