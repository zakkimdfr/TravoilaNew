//
//  HomepageView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 15/05/24.
//

import SwiftUI

struct HomepageView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundHomePage()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                Text("Hi,")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 22, weight: .regular))
                                
                                if let currentUser = userViewModel.user {
                                    Text(currentUser.name)
                                        .foregroundStyle(.white)
                                        .font(.system(size: 22, weight: .semibold))
                                } else {
                                    Text("User")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 22, weight: .semibold))
                                }
                            }
                            .frame(width: 247, alignment: .leading)
                            
                            Text("Explore the unseen place with Travoila")
                                .foregroundStyle(.white)
                                .font(.system(size: 14, weight: .regular))
                                .padding(.top, -10)
                        }
                        .frame(width: 247, height: 50, alignment: .leading)
                        
                        Spacer()
                        
                        NavigationLink(destination: ProfileView()) {
                            ZStack {
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                                
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(Color.themeColor(.primary))
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .frame(width: 352)
                    
                    TripView()
                        .padding()
                }
            }
        }
        .navigationBarHidden(true)
    }
}


#Preview {
    HomepageView()
        .environmentObject(UserViewModel(userService: AuthManager.shared, firestoreService: FirestoreManager.shared))
}

struct BackgroundHomePage: View {
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .foregroundColor(Color.themeColor(.primary))
                    .ignoresSafeArea()
                    .frame(height: 260)
                
                Rectangle()
                    .foregroundColor(Color(red: 249/255, green: 250/255, blue: 251/255))
            }
        }
    }
}
