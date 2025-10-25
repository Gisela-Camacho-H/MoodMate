//
//  HomeView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @ObservedObject var tabManager: TabManager
    
    var body: some View {
                VStack(spacing:20) {
                    Image("Banner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .padding(.top, -155)
                    
                    Text("Emotions are part of God's design \nlistening to them is a strength")
                        .font(.custom("AvenirNext-Bold", size: 20))
                        .foregroundColor(Color("BlueMood"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    
                    ConditionButton(title: "Log my mood",
                                    action: { tabManager.selectionTab = .mood
                    })
                    
                    PlusButton(backgroundColor: "CoralMood", action: {
                        tabManager.selectionTab = .mood }, size: 28, padding: 15)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Quote of the day:")
                            .font(.custom("AvenirNext-Bold", size: 20))
                            .foregroundColor(Color("GreenMood"))
                            .padding(.horizontal)
                        
                        QuoteCardHomeView(
                            quote: viewModel.quoteOfTheDay,
                            isLoading: viewModel.isLoading)
                    }
                }
                .onAppear { viewModel.fetchQuote() }
            }
        }

#Preview {
    let tabManager = TabManager()
    HomeView(tabManager: tabManager)
}
