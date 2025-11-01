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
    
    let currentUser = Auth.auth().currentUser
    

    let userName: String = Auth.auth().currentUser?.displayName ?? "Guess"
    let userEmail: String = Auth.auth().currentUser?.email ?? "Without email"
    
    @State private var selectedImageItem: PhotosPickerItem? = nil
    @State private var profileImage: Image? = nil
    
    private var googlePhotoURL: URL? {

        return currentUser?.photoURL
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
                    
                    Group {
                        if profileImage != nil {
                        
                            profileImage!.resizable()
                                .styledImage()
                        } else if let url = googlePhotoURL {
   
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
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
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)

                }
                .padding(.bottom, 20)
                .onChange(of: selectedImageItem) { _, newItem in
                    Task {
                        if let data =  try? await newItem?.loadTransferable(type: Data.self) {
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
                        .font(.custom("AvenirNext-Bold", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            loadSavedImage()
        }
    }
    

    
    func logout() {
        do {
            UserDefaults.standard.removeObject(forKey: kProfileImageKey)
            profileImage = nil
            try authController.signOut()
        } catch {
            print("Error to logout: \(error.localizedDescription)")
        }
    }
    
    func saveImageData(_ data: Data) {
        UserDefaults.standard.set(data, forKey: kProfileImageKey)
    }
    
    func loadSavedImage() {
        if let imageData =  UserDefaults.standard.data(forKey: kProfileImageKey) {
            loadImage(from: imageData)
        }
    }
    
    func loadImage(from data: Data) {
        if let uiImage = UIImage(data: data) {
            profileImage = Image(uiImage: uiImage)
        } else {
            profileImage =  nil
        }
    }
}

extension View {
    func styledImage() -> some View {
        self
            .clipShape(Rectangle())
            .overlay(Rectangle().stroke(Color("BlueMood"), lineWidth: 4))
            .shadow(color: Color.black.opacity(0.2), radius: 10)
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
