//
//  ProfileView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI
import PhotosUI
import FirebaseAuth

private let kProfileImageKey = "userProfilImageData"

struct ProfileView: View {
    
    @Environment(AuthController.self) private var authController
    
    private var currentUser: FirebaseAuth.User? {
        return Auth.auth().currentUser
    }
    
    private var userName: String {
        return currentUser?.displayName ?? "Guest"
    }
    
    private var userEmail: String {
        if let email = currentUser?.email, !email.isEmpty {
            return email
        } else {
            return "Email not available"
        }
    }
    
    private var providerPhotoURL: URL? {
        return currentUser?.photoURL
    }
    
    @State private var selectedImageItem: PhotosPickerItem? = nil
    @State private var profileImage: Image? = nil
    

    @ViewBuilder
    private func profileImageContent() -> some View {
        if profileImage != nil {
            profileImage!
                .resizable()
                .styledImage()
        } else if let url = providerPhotoURL {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 200, height: 200)
                        .clipShape(Rectangle())
                        .shadow(color: Color.shadowMood.opacity(0.2), radius: 10)
                case .success(let image):
                    image.resizable()
                        .styledImage()
                case .failure:
                    DefaultAvatar()
                @unknown default:
                    DefaultAvatar()
                }
            }
        } else {
            DefaultAvatar()
        }
    }
    
    var body: some View {
        ZStack {
            Color("BaseMood")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                
                Text("Profile")
                    .font(.custom("AvenirNext-Bold", size: 45))
                    .foregroundColor(Color("CoralMood"))
                    .padding(.top, 40)

                PhotosPicker(selection: $selectedImageItem, matching: .images) {
                    profileImageContent()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                }
                .padding(.bottom, 20)
                .onChange(of: selectedImageItem) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            loadImage(from: data)
                            saveImageData(data)
                        }
                    }
                }
                
                VStack(spacing: 30) {
                    ProfileRow(iconName: "person.fill", value: userName)
                    ProfileRow(iconName: "envelope.fill", value: userEmail)
                }
                .padding(.horizontal, 40)
                
                Spacer()
                
                Button(action: { logout() }) {
                    Text("Logout")
                        .font(.custom("AvenirNext-Bold", size: 32))
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity)
                        .background(Color("CoralMood"))
                        .cornerRadius(15)
                        .shadow(color: Color.shadowMood.opacity(0.15), radius: 10, x: 0, y: 10)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            loadSavedImage()
        }
    }
    
    
    @MainActor
    func logout() {
        do {
            UserDefaults.standard.removeObject(forKey: kProfileImageKey)
            profileImage = nil
            try authController.signOut()
        } catch {
            print("Error al cerrar sesión: \(error.localizedDescription)")
        }
    }
    
    func saveImageData(_ data: Data) {
        UserDefaults.standard.set(data, forKey: kProfileImageKey)
    }
    
    func loadSavedImage() {
        if let imageData = UserDefaults.standard.data(forKey: kProfileImageKey) {
            loadImage(from: imageData)
        }
    }
    
    func loadImage(from data: Data) {
        if let uiImage = UIImage(data: data) {
            profileImage = Image(uiImage: uiImage)
        } else {
            profileImage = nil
        }
    }
}

extension View {
    func styledImage() -> some View {
        self
            .clipShape(Rectangle())
            .overlay(Rectangle().stroke(Color("BlueMood"), lineWidth: 4))
            .shadow(color: Color.shadowMood.opacity(0.2), radius: 10)
            .frame(width: 200, height: 200)
    }
}

struct DefaultAvatar: View {
    var body: some View {
        Image("ProfileAvatar")
            .resizable()
            .foregroundColor(Color("BlueMood"))
            .frame(width: 200, height: 200)
    }
}

#Preview {
    ProfileView()
        .environment(AuthController())
}
