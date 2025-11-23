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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
    let coralColor = Color("CoralMood")
    let lightBlue = Color("BaseMood")

    var body: some View {
        ZStack {
            lightBlue.ignoresSafeArea(.all)

            VStack {
                Text("My Mood Track")
                    .font(.custom("AvenirNext-Bold", size: isIPad ? 60 : 45))
                    .foregroundColor(coralColor)
                    .padding(.top, isIPad ? 20 : 10)

                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: isIPad ? 50 : 30)
                        .fill(Color.white)
                        .stroke(coralColor, lineWidth: 2)
                        .shadow(color: .shadowMood.opacity(0.3), radius: 10, x: 0, y: 10)
                        .padding(.horizontal, isIPad ? 50 : 30)

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
                        .padding(.top, isIPad ? 40 : 30)
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
                        size: isIPad ? 40 : 20,
                        padding: isIPad ? 15 : 10
                    )
                }
                .padding(.trailing, isIPad ? 80 : 40)
                .padding(.bottom, isIPad ? 40 : 25)
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
