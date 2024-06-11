//
//  AuthManager.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 11/06/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthManager: UserService {
    static let shared = AuthManager()
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = authResult?.user else { return }
            completion(.success(user))
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = authResult?.user else { return }
            completion(.success(user))
        }
    }
    
    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func updateUser(user: UserModel, completion: @escaping ((any Error)?) -> Void) {
        FirestoreManager.shared.updateUser(user: user, completion: completion)
    }
    
}

