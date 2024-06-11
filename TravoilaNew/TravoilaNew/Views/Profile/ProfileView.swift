//
//  ProfileView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 05/06/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var name: String = ""
    @State private var isShowed: Bool = true
    @State private var placeholderText: String = ""
    @State private var showAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person.fill")
                .resizable()
                .foregroundColor(Color.themeColor(.primary))
                .frame(width: 123, height: 123)
                .clipShape(Circle())
            
            Button(action: {}) {
                Text("Change Profile Photo")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.themeColor(.primary))
                    .padding(.leading)
            }
            .padding()
            
            InputView(text: $name,
                      title: "Name",
                      placeholder: placeholderText,
                      isSecured: false,
                      isShowed: $isShowed)
            .onAppear {
                if let currentUser = userViewModel.user {
                    placeholderText = currentUser.name
                }
            }
            
            NavigationLink(destination: LoginView()) {
                Button(action: {
                    userViewModel.signOut()
                }) {
                    Text("Sign Out")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 200, height: 50)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.themeColor(.primary)))
                }
                .padding(.top, 50)
            }
            
            Spacer()
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton()
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    userViewModel.user?.name = name
                    userViewModel.updateUserDetails { success in
                        if success {
                            showAlert = true
                        }
                    }
                }) {
                    Text("Done")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.themeColor(.primary))
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Name has been updated"),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserViewModel(userService: AuthManager.shared, firestoreService: FirestoreManager.shared))
    
}
