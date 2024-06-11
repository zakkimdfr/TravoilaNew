//
//  TabBarView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 28/05/24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    @State var presented = false
    @EnvironmentObject var userViewModel: UserViewModel
    
    let icons = [
        "Overview",
        "Plus",
        "Notification"
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                switch selectedTab {
                case 0:
                    HomepageView()
                    
                case 1:
                    AddTripView(isPresented: $presented)
                    
                default:
                    NotificationView()

                }
                
            }
            
            Spacer()
            Divider()
            
            HStack(spacing: 45) {
                ForEach(0..<3, id: \.self) { number in
                    Button(action: {
                        if number == 1 {
                            presented.toggle()
                        } else {
                            self.selectedTab = number
                        }
                    }) {
                        if number == 1 {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 46, height: 46)
                                    .foregroundColor(Color.themeColor(.primary))
                                Image(icons[number])
                            }
                            
                        } else {
                            VStack {
                                Image(icons[number])
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                                Text(icons[number])
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(.top, 2)
                            }
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $presented, content: {
            AddTripView(isPresented: $presented)
        })
        .background(Color.white)
        .ignoresSafeArea()
        .padding(.bottom, 1)
    }
}

#Preview {
    TabBarView()
        .environmentObject(UserViewModel(userService: AuthManager.shared,
                                         firestoreService: FirestoreManager.shared))
}
