//
//  TrackView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct TrackView: View {
    
    @StateObject var viewModel: TrackViewModel = TrackViewModel(service: MockMoodLogService())
    @ObservedObject var tabManager: TabManager
    
    let coralColor = Color("CoralMood")
    let lightBlue = Color("BaseMood")
    
    var body: some View {
        
        ZStack {
            lightBlue.ignoresSafeArea(.all)
            
            VStack {
                Text("My Mood Track")
                    .font(.custom("AvenirNext-Bold", size: 45))
                    .foregroundColor(coralColor)
                    .padding(.top, 10)
                
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 25).fill(Color.white)
                        .stroke(coralColor, lineWidth: 2)
                        .shadow(color: .black.opacity(0.3), radius: 8, x:0, y:5)
                        .padding(.horizontal, 25)
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            if viewModel.isLoading {
                                ProgressView("Loading").padding(.vertical, 50)
                            } else {
                                ForEach(viewModel.moodLogs) { log in
                                    TimeLineRow(log: log)
                                }
                                Rectangle().fill(.clear).frame(height: 10)
                            }
                        }
                        .padding(.leading, 60).padding(.vertical, 20)
                    }
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    PlusButton(backgroundColor: "BlueMood", action: {
                        tabManager.selectionTab = .mood }, size: 20, padding: 10)
                }.padding(.trailing, 40).padding(.bottom, 25)
            }
        }
    }
}

#Preview {
    TrackView(tabManager: TabManager())
}
