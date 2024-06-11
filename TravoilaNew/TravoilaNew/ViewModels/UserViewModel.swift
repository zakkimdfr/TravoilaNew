//
//  UserViewModel.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 17/05/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var isLoggedIn: Bool = false
    @Published var isRegistered: Bool = false
    @Published var errorMessage: String?
    @Published var passwordResetSent: Bool = false
    @Published var filteredUsers: [UserModel] = []
    @Published var searchedUsers: [UserModel] = []
    @Published var userSession: FirebaseAuth.User?
    @Published var isLoading: Bool = false
    
    private let userService: UserService
    private let firestoreService: FirestoreService
    
    private let userDefaults = UserDefaults.standard
    private let userSessionKey = "userSessionKey"
    
    init(userService: UserService, firestoreService: FirestoreService) {
        self.userService = userService
        self.firestoreService = firestoreService
        self.restoreUserSession()
    }
    
    func signUp(name: String, email: String, password: String) {
        isLoading = true
        userService.signUp(email: email, password: password) { result in
            switch result {
            case .success(let firebaseUser):
                self.user = UserModel(uid: firebaseUser.uid,
                                      name: name,
                                      email: email,
                                      password: password)
                self.isRegistered = true
                self.saveToFirebase()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isRegistered = false
            }
        }
    }
    
    func signIn(email: String, password: String) {
        isLoading = true
        userService.signIn(email: email, password: password) { result in
            switch result {
            case .success(let firebaseUser):
                self.user = UserModel(uid: firebaseUser.uid, name: "", email: email, password: password)
                self.isLoggedIn = true
                self.fetchUserDetails()
                self.saveUserSession()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isLoggedIn = false
            }
        }
    }
    
    func signOut() {
        isLoading = false
        userService.signOut { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.user = nil
                self.isLoggedIn = false
                self.clearUserSession()
            }
        }
    }
    
    func saveToFirebase() {
        guard let user = user else { return }
        firestoreService.saveUser(user: user) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func updateUserDetails(completion: @escaping (Bool) -> Void) {
        guard let user = user else {
            completion(false)
            return
        }
        firestoreService.updateUser(user: user) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func fetchUserDetails() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        firestoreService.fetchUser(uid: uid) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    private func saveUserSession() {
        userDefaults.set(user?.uid, forKey: userSessionKey)
    }
    
    
    private func restoreUserSession() {
        if let uid = userDefaults.string(forKey: userSessionKey) {
            Auth.auth().addStateDidChangeListener { auth, user in
                if let user = user {
                    self.userSession = user
                    self.user = UserModel(uid: user.uid, name: "", email: user.email ?? "", password: "")
                    self.isLoggedIn = true
                    self.fetchUserDetails()
                } else {
                    self.errorMessage = "User not found"
                    self.isLoggedIn = false
                }
            }
        }
    }
    
    private func clearUserSession() {
        userDefaults.removeObject(forKey: userSessionKey)
    }

    func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "(?:[a-zA-Z0-9!#$%\\&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailPred.evaluate(with: email)
        }
}
