//
//  WelcomeView.swift
//  MoodMate
//
//  Created by Gis Cam on 17/10/25.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BlueBackground")
                    .ignoresSafeArea()
                
                VStack(spacing: isIPad ? 40 : 20) {
                    
                    Image("Name")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: isIPad ? 300 : 100,
                            height: isIPad ? 200 : 100
                        )
                        .padding(.top, isIPad ? 40 : 20)

                    isIPad ? nil : Spacer()

                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: isIPad ? 400 : 250,
                            height: isIPad ? 400 : 250
                        )
                        .padding(.bottom, isIPad ? 0 : 130)

                    
                    VStack(spacing: isIPad ? 25 : 20) {
                        NavigationButton(title: "Login", destination: LoginView())
                        
                        NavigationTextLink(
                            messageText: "Don't have an account?",
                            linkText: "Sign up",
                            destination: SignUpView()
                        )
                        .font(.system(size: isIPad ? 26 : 16))
                    }
                    .padding(.bottom, isIPad ? 60 : 30)
                }
                .padding(.horizontal, isIPad ? 80 : 20)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
    }
}

#Preview {
    WelcomeView()
}
