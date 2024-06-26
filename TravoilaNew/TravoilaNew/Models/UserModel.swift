//
//  UserModel.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 16/05/24.
//

import Foundation

struct UserModel: Identifiable, Codable {
    var id: String {uid}
    let uid: String
    var name: String
    var email: String
    var password: String
}
