//
//  OnboardingView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 15/05/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentStep = 0
    @Binding var isOnboardingCompleted: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.themeColor(.primary)
                    .ignoresSafeArea(edges: .all)
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.currentStep = OnboardData.count - 1
                        }) {
                            Text(currentStep < OnboardData.count - 1 ? "Skip" : "")
                                .padding(.trailing, 35)
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .semibold))
                        }
                    }
                    
                    TabView(selection: $currentStep) {
                        ForEach(OnboardData) {item in
                                OnboardingStepView(item: item)
                                .tag(OnboardData.firstIndex(where: { $0.id == item.id }) ?? 0)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .padding(.bottom, 100)
                    
                    NavigationLink(destination: LoginView()) {
                        Button(action: {
                            if currentStep < OnboardData.count - 1 {
                                currentStep += 1
                            } else {
                                isOnboardingCompleted = true
                            }
                        }) {
                            Text(currentStep < OnboardData.count - 1 ? "Next" : "Get Started")
                                .font(.system(size: 15, weight: .semibold))
                                .frame(width: 183, height: 55)
                                .background(.white)
                                .cornerRadius(10)
                        }
                    }
                   
                    
                    Spacer()
                        .frame(height: 50)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

//#Preview {
//    OnboardingView(isOnboardingCompleted: $isOnboardingCompleted)
//}

struct OnboardingStepView: View {
    var item: Onboard

    var body: some View {
        VStack {
            Image(item.image)
                .resizable()
                .frame(width: 275, height: 250)
            
            Text(item.title)
                .font(.system(size: 18, weight: .semibold))
                .padding(.top, 24)
                .foregroundColor(.white)
            
            Text(item.desc)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.white)
                .padding(.top, -5)
        }
        .padding()
    }
}
