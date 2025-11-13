//
//  TrackView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI
import FirebaseAuth

struct TrackView: View {

    @StateObject private var viewModel = TrackViewModel()
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
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .stroke(coralColor, lineWidth: 2)
                        .shadow(color: .shadowMood.opacity(0.3), radius: 8, x: 0, y: 5)
                        .padding(.horizontal, 25)

                    ScrollView {
                        VStack(spacing: 0) {
                            if viewModel.isLoading {
                                ProgressView("")
                                    .padding(.vertical, 50)
                            } else if viewModel.moodLogs.isEmpty {
                                EmptyStateView {
                                    tabManager.selectionTab = .mood
                                }
                            } else {
                                ForEach(viewModel.moodLogs) { log in
                                    TimeLineRow(log: log)
                                }
                                .padding(.leading, 60)
                            }
                        }
                        .padding(.top, 30)
                    }
                }
                Spacer()
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    PlusButton(
                        backgroundColor: "BlueMood",
                        action: { tabManager.selectionTab = .mood },
                        size: 20,
                        padding: 10
                    )
                }
                .padding(.trailing, 40)
                .padding(.bottom, 25)
            }
        }
        .onAppear {
                viewModel.fetchMoodLogs()
        }
    }
}

#Preview {
    TrackView(tabManager: TabManager())
}
