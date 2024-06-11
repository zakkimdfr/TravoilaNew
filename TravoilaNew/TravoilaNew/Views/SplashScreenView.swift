//
//  SplashScreenView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 15/05/24.
//

import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var isActive: Bool = false
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    var body: some View {
        ZStack {
            Color.themeColor(.primary)
                .ignoresSafeArea(edges: .all)
            
            if self.isActive {
                if isOnboardingCompleted && userViewModel.isLoggedIn {
                    TabBarView()
                } else if isOnboardingCompleted && userViewModel.isLoggedIn == false{
                    LoginView()
                } else {
                    OnboardingView(isOnboardingCompleted: $isOnboardingCompleted)
                }
            } else {
                HStack {
                    Image("Logo")
                    Text("TRAVOILA!")
                        .font(.system(size: 28.57, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }
        }
        .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            self.isActive = true
                            print(userViewModel.user ?? "euweuhan")
                        }
                    }
                }
    }
}

#Preview {
    SplashScreenView()
}
