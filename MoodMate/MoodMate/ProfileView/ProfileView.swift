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
    
    @EnvironmentObject var authController: AuthController
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
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
                .styledImage(width: isIPad ? 300 : 200, height: isIPad ? 300 : 200)
        } else if let url = providerPhotoURL {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: isIPad ? 300 : 200, height: isIPad ? 300 : 200)
                        .clipShape(Rectangle())
                        .shadow(color: Color.shadowMood.opacity(0.2), radius: 10)
                case .success(let image):
                    image.resizable()
                        .styledImage(width: isIPad ? 300 : 200, height: isIPad ? 300 : 200)
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
            
            VStack(spacing: isIPad ? 80 : 40) {
                
                Text("Profile")
                    .font(.custom("AvenirNext-Bold", size: isIPad ? 65 : 45))
                    .foregroundColor(Color("CoralMood"))
                    .padding(.top, 40)

                PhotosPicker(selection: $selectedImageItem, matching: .images) {
                    profileImageContent()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: isIPad ? 300 : 200, height: isIPad ? 300 : 200)
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
                
                VStack(spacing: isIPad ? 40 : 30) {
                    ProfileRow(iconName: "person.fill", value: userName)
                    ProfileRow(iconName: "envelope.fill", value: userEmail)
                }
                .padding(.horizontal, isIPad ? 80 : 40)
                
                Spacer()
                
                Button(action: { logout() }) {
                    Text("Logout")
                        .font(.custom("AvenirNext-Bold", size: isIPad ? 40 : 32))
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity)
                        .background(Color("CoralMood"))
                        .cornerRadius(15)
                        .shadow(color: Color.shadowMood.opacity(0.15), radius: 10, x: 0, y: 10)
                }
                .padding(.horizontal, isIPad ? 60 : 40)
                .padding(.bottom, isIPad ? 70 : 50)
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
            print("Logged out")
        } catch {
            print("❌ Logout error: \(error.localizedDescription)")
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
    
    func styledImage(width: CGFloat, height: CGFloat) -> some View {
        self
            .clipShape(Rectangle())
            .overlay(Rectangle().stroke(Color("BlueMood"), lineWidth: 4))
            .shadow(color: Color.shadowMood.opacity(0.2), radius: 10)
            .frame(width: width, height: height)
    }
}

struct DefaultAvatar: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
    var body: some View {
        Image("ProfileAvatar")
            .resizable()
            .foregroundColor(Color("BlueMood"))
            .frame(width: isIPad ? 300 : 200, height: isIPad ? 300 : 200)
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthController())
}
