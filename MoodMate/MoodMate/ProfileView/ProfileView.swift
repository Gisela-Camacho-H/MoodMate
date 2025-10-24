//
//  ProfileView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI
import PhotosUI

private let kProfileImageKey = "userProfilImageData"

struct ProfileView: View {
    
    let userName = "Gisela Camacho"
    let userEmail = "gis25cam@gmail.com"
    
    @State private var selectedImageItem: PhotosPickerItem? = nil
    @State private var profileImage: Image? = nil
    
    var body: some View {
        ZStack {
            Color(.white)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                
                Text("Profile")
                    .font(.custom("AvenirNext-Bold", size: 45))
                    .foregroundColor(Color("CoralMood"))
                    .padding(.top, 40)
                
                PhotosPicker(selection: $selectedImageItem, matching: .images) {
                    profileImage?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Rectangle())
                        .overlay(Rectangle().stroke(Color("BlueMood"), lineWidth: 4))
                        .shadow(color: Color.black.opacity(0.2), radius: 10)
                    
                    if profileImage == nil {
                        ZStack {
                            Image("ProfileAvatar")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .foregroundColor(Color("BlueMood"))
                        }
                        
                    }
                }
                .padding(.bottom, 20)
                .onChange(of: selectedImageItem) { oldItem, newItem in
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
            }
        }
        .onAppear {
            loadSavedImage()
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

#Preview {
    ProfileView()
}
