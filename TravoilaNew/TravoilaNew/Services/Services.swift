//
//  Services.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 05/06/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol UserService {
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signOut(completion: @escaping (Error?) -> Void)
    func updateUser(user: UserModel, completion: @escaping (Error?) -> Void)
}

protocol FirestoreService {
    func saveUser(user: UserModel, completion: @escaping (Error?) -> Void)
    func fetchUser(uid: String, completion: @escaping (Result<UserModel, Error>) -> Void)
    func updateUser(user: UserModel, completion: @escaping (Error?) -> Void)
}

protocol AuthForm {
    var formIsValid: Bool { get }
}
