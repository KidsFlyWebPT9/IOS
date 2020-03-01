//
//  User.swift
//  KidsFly
//
//  Created by Dillon P on 3/1/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation

struct User: Codable {
    let username: String
    let password: String
}

struct Users: Codable {
    let id : Int
    let username: String
    let password: String
}
