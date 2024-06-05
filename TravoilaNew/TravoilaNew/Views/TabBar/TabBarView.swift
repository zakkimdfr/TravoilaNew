//
//  TabBarView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 28/05/24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        TabView (selection: $selectedTab){
            HomepageView()
                .tabItem {
                    VStack {
                        Image(selectedTab == 0 ? "HomeActive" : "Home")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Overview")
                            .font(.system(size: 12))
                            .fontWeight(selectedTab == 0 ? .semibold : .regular)
                    }
                }
                .tag(0)
            
            AddTripView()
                .tabItem {
                    Image(systemName: "plus")
                         .resizable()
                         .foregroundColor(.white)
                         .background(
                             RoundedRectangle(cornerRadius: 10)
                                 .frame(width: 46, height: 46)
                                 .foregroundColor(Color.themeColor(.primary))
                             
                         )
                         .frame(width: 18, height: 18)
                }
                .tag(1)
            
            NotificationView()
                .tabItem {
                    VStack {
                        Image(selectedTab == 2 ? "NotificationActive" : "Notification")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Notification")
                            .font(.system(size: 12))
                            .fontWeight(selectedTab == 2 ? .semibold : .regular)
                    }
                }
                .tag(2)
        }
        .accentColor(.themeColor(.primary))
        .onAppear() {
            print(userViewModel.currentUser ?? "kosong")
            print(UserDefaults.standard.object(forKey: "name" ?? "kosong"))
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(UserViewModel())
}
