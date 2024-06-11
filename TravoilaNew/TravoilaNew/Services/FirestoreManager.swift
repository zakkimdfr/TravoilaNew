//
//  FirestoreManager.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 11/06/24.
//

import Foundation
import FirebaseFirestore

class FirestoreManager: FirestoreService {
    static let shared = FirestoreManager()
    private var db = Firestore.firestore()
    
    func saveUser(user: UserModel, completion: @escaping (Error?) -> Void) {
        do {
            try db.collection("users").document(user.uid).setData(from: user)
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func fetchUser(uid: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        db.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                do {
                    let user = try document.data(as: UserModel.self)
                    completion(.success(user))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User does not exist."])))
            }
        }
    }
    
    func updateUser(user: UserModel, completion: @escaping(Error?) -> Void) {
        do {
            try db.collection("users").document(user.uid).setData(from: user, merge: true)
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
}
