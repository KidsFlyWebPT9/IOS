//
//  UserRepresentation.swift
//  KidsFly
//
//  Created by dillon on 3/4/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation

struct UserRepresentation: Equatable, Codable {
    var id: Int16? = nil
    var username: String
    var password: String
    var image: String? = nil
    var name: String? = nil
    var address: String? = nil
    var airport_id: Int16? = nil
    var phone: String? = nil
}
