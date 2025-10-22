//
//  LoginView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password : String = ""
    
    @Environment(\.dismiss) var dismiss
    
    private var cardShadow: Color {
        Color("BlueMood")
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
                            
                            SecureField("Password", text: $password)
                                .modifier(TextFieldMoodMate(iconName: "key.horizontal.fill"))
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.vertical, 30)
                    .frame(width: geometry.size.width * 0.9)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: cardShadow.opacity(0.3), radius: 10, x:0, y: 5)
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x:0, y: 5)
                    
                    NavigationButton(title: "Login", destination: MainTabView())
                    
                    Spacer()
                    
                    NavigationTextLink(
                        messageText: "Don't have an account?",
                        linkText: "Sign up",
                        destination: SignUpView())
                }
                .padding(.bottom, 20)
            }
            .padding(.top, 100)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BaseMood"))
        }
    }
}

#Preview {
    LoginView()
}
