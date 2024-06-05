//
//  RegisterView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 15/05/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var picture: String = ""
    @State private var uid: String = ""
    @State private var showAlert: Bool = false
    @State private var isShowed: Bool = false
    @State private var isConfirmShowed: Bool = false
    @StateObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    func checkPassword() {
        if password == confirmPassword {
            userViewModel.authError = nil
        } else {
            userViewModel.authError = "Passwords do not match"
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundTheme()
                VStack {
                    Spacer()
                    Logo()
                    
                    InputFieldWithValidation(text: $name,
                                             title: "Name",
                                             placeholder: "Enter Your Name",
                                             isSecured: false,
                                             isEmpty: name.isEmpty,
                                             isShowed: $isShowed)
                    .textInputAutocapitalization(.words)
                    
                    InputFieldWithValidation(text: $email,
                                             title: "Email",
                                             placeholder: "Enter Your Email",
                                             isSecured: false,
                                             isEmpty: email.isEmpty,
                                             isShowed: $isShowed,
                                             keyboardType: .emailAddress)
                    .textInputAutocapitalization(.never)
                    
                    InputFieldWithValidation(text: $password,
                                             title: "Password",
                                             placeholder: "Enter Your Password",
                                             isSecured: true,
                                             isEmpty: password.isEmpty,
                                             isShowed: $isShowed)
                    .textInputAutocapitalization(.never)
                    
                    InputFieldWithValidation(text: $confirmPassword,
                                             title: "Confirm Password",
                                             placeholder: "Confirm Your Password",
                                             isSecured: true,
                                             isEmpty: confirmPassword.isEmpty,
                                             isShowed: $isConfirmShowed)
                    .textInputAutocapitalization(.never)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword && password.count > 7 {
                            ValidationMessage(image: "checkmark.circle", message: "Password match", color: .green)
                                .frame(width: UIScreen.main.bounds.width - 35, alignment: .trailing)
                        } else {
                            ValidationMessage(image: "xmark.circle", message: "Password did not match!", color: .red)
                                .frame(width: UIScreen.main.bounds.width - 35, alignment: .trailing)
                                .padding(.trailing)
                        }
                    }
                    
                    NavigationLink(destination: LoginView(), isActive: $userViewModel.isRegistered) {
                        Button(action: {
                            validateAndSignUp()
                        }) {
                            ButtonView(button: "Sign Up")
                        }
                    }
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    
                    Spacer()
                    
                    HStack {
                        Text("Already have an account? | ")
                            .foregroundColor(.white)
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Sign In")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding()
                }
                if userViewModel.isLoading {
                    LoadingView()
                }
            }
        }
    }
    
    private func validateAndSignUp() {
        checkPassword()
        if userViewModel.authError != nil || name.isEmpty || email.isEmpty || password.isEmpty {
            showAlert = true
        } else if userViewModel.isValidEmail(email) {
            userViewModel.signUp(uid: uid, name: name, email: email, password: password, picture: picture)
        }
    }
}

#Preview {
    RegisterView(userViewModel: UserViewModel())
}

extension RegisterView: AuthForm {
    var formIsValid: Bool {
        let isValid = !email.isEmpty
        && userViewModel.isValidEmail(email)
        && !password.isEmpty
        && password.count > 7
        && !name.isEmpty
        && password == confirmPassword
        return isValid
    }
}

struct InputFieldWithValidation: View {
    @Binding var text: String
    var title: String
    var placeholder: String
    var isSecured: Bool
    var isEmpty: Bool
    @Binding var isShowed: Bool
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        ZStack {
            InputView(text: $text,
                      title: title,
                      placeholder: placeholder,
                      isSecured: isSecured,
                      isShowed: $isShowed)
            .autocorrectionDisabled()
            .keyboardType(keyboardType)
            
            if isEmpty {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2.0)
                    .frame(width: UIScreen.main.bounds.width - 35, height: 62)
                    .foregroundColor(.red)
            }
        }
        if isEmpty {
            Text("\(title) is required!")
                .foregroundStyle(.red)
                .font(.caption)
                .frame(width: UIScreen.main.bounds.width - 35, alignment: .leading)
                .padding(.leading)
        }
    }
}

struct ValidationMessage: View {
    var image: String
    var message: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: image)
            Text(message)
        }
        .foregroundColor(color)
        .font(.caption)
    }
}
