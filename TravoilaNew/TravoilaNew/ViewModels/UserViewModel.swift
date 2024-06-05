//
//  UserViewModel.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 17/05/24.
//

import Foundation
import Firebase

class UserViewModel: ObservableObject {
    @Published var currentUser: UserModel?
    @Published var isLoggedIn: Bool = false
    @Published var isRegistered: Bool = false
    @Published var authError: String?
    @Published var isLoading: Bool = false
    
    init() {
        loadUserFromUserDefault()
    }
    
    func signIn(email: String, password: String) {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            self?.isLoading = false
            if let error = error {
                self?.authError = error.localizedDescription
                self?.isLoggedIn = false
            } else {
                self?.isLoggedIn = true
                self?.fetchUserData()
                self?.saveUserToUserDefault()
            }
        }
    }
    
    func signUp(uid: String, name: String, email: String, password: String, picture: String) {
        isLoading = true
        authError = nil
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            self?.isLoading = false
            if let error = error {
                self?.authError = error.localizedDescription
                self?.isRegistered = false
            } else {
                guard let user = result?.user else { return }
                let uid = user.uid
                self?.saveUserToFirestore(uid: uid, name: name , email: email, password: password, picture: picture)
            }
        }
    }
    
    func saveUserToFirestore(uid: String, name: String, email: String, password: String, picture: String) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).setData([
            "uid": uid,
            "name": name,
            "email": email,
            "password": password,
            "picture": picture
        ]) { error in
            if let error = error {
                print("Error saving user data: \(error)")
                self.authError = error.localizedDescription
                self.isRegistered = false
            } else {
                self.currentUser = UserModel(uid: uid, name: name, email: email, password: password, picture: picture)
                self.isRegistered = true
                self.saveUserToUserDefault()
            }
        }
    }
    
    func fetchUserData() {
        guard let user = Auth.auth().currentUser else {return}
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).getDocument { [weak self] document, error in
            if let document = document, document.exists, let data = document.data() {
                let uid = data["uid"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                let picture = data["picture"] as? String ?? ""
                self?.currentUser = UserModel(uid: uid, name: name, email: email, password: password, picture: picture)
            } else {
                print("user does not exist")
            }
        }
    }
    
    func updateUser(name: String, email: String, picture: String) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        db.collection("users").document(uid).updateData([
            "name": name,
            "email": email,
            "picture": picture
        ]) { error in
            if let error = error {
                print("Error updating user data: \(error)")
                self.authError = error.localizedDescription
            } else {
                self.currentUser?.name = name
                self.currentUser?.email = email
                self.currentUser?.picture = picture
            }
        }
    }
    
    func saveUserToUserDefault() {
        guard let user = currentUser else { return }
        UserDefaults.standard.set(user.uid, forKey: "uid")
        UserDefaults.standard.set(user.name, forKey: "name")
        UserDefaults.standard.set(user.email, forKey: "email")
        UserDefaults.standard.set(user.password, forKey: "password")
        UserDefaults.standard.set(user.picture, forKey: "picture")
        UserDefaults.standard.synchronize()
    }
    
    func loadUserFromUserDefault() {
        guard let uid = UserDefaults.standard.string(forKey: "uid"),
              let name = UserDefaults.standard.string(forKey: "name"),
              let email = UserDefaults.standard.string(forKey: "email"),
              let password = UserDefaults.standard.string(forKey: "password"),
              let picture = UserDefaults.standard.string(forKey: "picture") else {
            self.isLoggedIn = false
            return
        }
        self.currentUser = UserModel(uid: uid, name: name, email: email, password: password, picture: picture)
        self.isLoggedIn = true
    }
    
    func removeUserFromUserDefault() {
        UserDefaults.standard.removeObject(forKey: "uid")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "picture")
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.currentUser = nil
        self.isLoggedIn = false
        removeUserFromUserDefault()
    }

    func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "(?:[a-zA-Z0-9!#$%\\&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailPred.evaluate(with: email)
        }
}
