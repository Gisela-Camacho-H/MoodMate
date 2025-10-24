//
//  ProfileRow.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//
import SwiftUI

struct ProfileRow: View {
    let iconName: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 15) {
                Image(systemName: iconName)
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("BlueMood"))
                
                Text(value)
                .font(.custom("AvenirNext-Bold", size: 20))
                    .foregroundColor(Color("GrayMood"))
                
                Spacer()
            }.padding(.horizontal, 10)
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color("CoralMood"))
                .padding(.top)
        }
    }
}


#Preview {
  ProfileRow(iconName: "envelope.fill", value: "Gisela Camacho")
}
