//
//  TimeLineRow.swift
//  MoodMate
//
//  Created by Gis Cam on 24/10/25.
//

import SwiftUI

struct TimeLineRow: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
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
                    .font(.custom("AvenirNext-Bold", size: isIPad ? 30 : 20))
                    .foregroundColor(Color.black)
                    .fixedSize(horizontal: false, vertical: true)
                
                if let note = log.note, !note.isEmpty {
                    Text(note)
                        .font(.custom("AvenirNext-Regular", size:  isIPad ? 25 : 15))
                        .foregroundColor(Color("GrayMood"))
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: isIPad ? 250 : 130, alignment: .leading)
                }
            }
            .frame(width: isIPad ? 250 : 130, alignment: .leading)
            .padding(.trailing, isIPad ? 70 : 40)
            .padding(.leading, isIPad ? 40 : 5)
            
            VStack(spacing: 0) {
                Circle()
                    .stroke(lineColor, lineWidth: 1.5)
                    .background(Circle().fill(Color.white))
                    .frame(width: isIPad ? 15 : 10, height: isIPad ? 15 : 10)
                    .zIndex(1)
                
                Rectangle()
                    .fill(lineColor)
                    .frame(width: isIPad ? 4 : 3, height: isIPad ? 220 : 170)
            }
            
            Spacer()
            

            Image(log.emotionName)
                .resizable()
                .frame(width: isIPad ? 200 : 100, height: isIPad ? 200 : 100)
                .padding(.trailing, isIPad ? 60 : 40)
        }
        .frame(height: isIPad ? 220 : 170, alignment: .top)
        .padding(.trailing, 20)
    }
}

#Preview {
    TimeLineRow(log: MoodLogModel(emotionName: "Calm", note: "I'm very relax", date: Date(), userId: "" ))
    TimeLineRow(log: MoodLogModel(emotionName: "Empowered", note: "I can do it !!!!!", date: Date(), userId: "" ))
}
