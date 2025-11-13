//
//  TimeLineRow.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//

import SwiftUI

struct TimeLineRow: View {
    let log: MoodLogModel
    let lineColor = Color("CoralMood")
    
    private var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: log.date)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            
            VStack(alignment: .leading, spacing: 5) {
                Text(displayDate)
                    .font(.custom("AvenirNext-Bold", size: 20))
                    .foregroundColor(Color.black)
                
                if let note = log.note, !note.isEmpty {
                    Text(note)
                        .font(.custom("AvenirNext-Regular", size: 15))
                        .foregroundColor(Color("GrayMood"))
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: 130, alignment: .leading)
                }
            }
            .frame(width: 130, alignment: .leading)
            .padding(.trailing, 40)
            
            VStack(spacing: 0) {
                Circle()
                    .stroke(lineColor, lineWidth: 1.5)
                    .background(Circle().fill(Color.white))
                    .frame(width: 10, height: 10)
                    .zIndex(1)
                
                Rectangle()
                    .fill(lineColor)
                    .frame(width: 3, height: 170 - 10)
            }
            
            Spacer()
            

            Image(log.emotionName)
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.trailing, 40)
        }
        .frame(height: 170, alignment: .top)
        .padding(.trailing, 20)
    }
}
