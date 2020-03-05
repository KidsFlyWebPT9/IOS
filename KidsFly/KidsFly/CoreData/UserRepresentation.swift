//
//  UserRepresentation.swift
//  KidsFly
//
//  Created by dillon on 3/4/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation

struct UserRepresentation: Equatable, Codable {
    var id: Int16?
    var username: String
    var password: String
    var image: String?
    var name: String?
    var address: String?
    var airportId: String?
    var phone: String?
}