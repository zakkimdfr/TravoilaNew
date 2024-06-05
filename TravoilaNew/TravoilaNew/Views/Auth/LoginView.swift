//
//  LoginView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 15/05/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isShowed: Bool = false
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var isClicked: Bool = false
    @State private var isError: Bool = false
    @State private var showError: Bool = false
    @State private var isEmpty: Bool = false
    @State private var showAlert: Bool = false
    @State private var button: String = ""
    
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundTheme()
                
                VStack {
                    Spacer()
                    Logo()
                    
                    InputView(text: $email,
                              title: "Email",
                              placeholder: "mail@example.com",
                              isSecured: false,
                              isShowed: $isShowed)
                    
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecured: true,
                              isShowed: $isShowed)
                    
                    NavigationLink(
                        destination: TabBarView(), isActive: $userViewModel.isLoggedIn) {
                            Button(action: {
                                if userViewModel.authError != nil {
                                    showAlert = true
                                    showError = true                                }
                                userViewModel.signIn(email: email, password: password)
                            }) {
                                ButtonView(button: "Sign In")
                            }
                                
                        }
                        .disabled(!formIsValid)
                        .opacity(formIsValid ? 1.0 : 0.5)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Authentication Error"),
                                  message: Text(userViewModel.authError ?? "Unknown Error"),
                                  dismissButton: .default(Text("OK")))
                        }
                    
                    Text("OR")
                        .padding()
                        .foregroundColor(.white)
                    
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "apple.logo")
                                .resizable()
                                .frame(width: 24.57, height: 29.25)
                                .foregroundColor(.black)
                            
                            Text("Sign In With Apple ID")
                                .foregroundStyle(.black)
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(width: 357, height: 58)
                    .background(.white)
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    HStack {
                        Text("Don't have account? | ")
                            .foregroundStyle(.white)
                        
                        NavigationLink(destination: RegisterView(userViewModel: UserViewModel())) {
                            Text("Sign Up")
                                .foregroundStyle(.black)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding()
                    
                }
            }
            
            if userViewModel.isLoading{
                LoadingView()
            }
        }
        
        .navigationBarHidden(true)
    }
}

#Preview {
    LoginView()
        .environmentObject(UserViewModel())
}

extension LoginView: AuthForm {
    var formIsValid: Bool {
        let isValid = !email.isEmpty
        && !password.isEmpty
        print("Form is valid: \(isValid)")
        return isValid
    }
}


struct BackgroundTheme: View {
    var body: some View {
        Color.themeColor(.primary)
            .ignoresSafeArea()
        
        Image("Vector")
            .offset(x: -200, y: -440)
        
        Image("Vector")
            .offset(x: 0, y: -480)
            .rotationEffect(.degrees(180))
    }
}

struct Logo: View {
    var body: some View {
        Image("Logo")
            .padding(.bottom, 5)
        
        Text("TRAVOILA!")
            .font(.system(size: 28.57, weight: .semibold))
            .foregroundStyle(.white)
    }
}
