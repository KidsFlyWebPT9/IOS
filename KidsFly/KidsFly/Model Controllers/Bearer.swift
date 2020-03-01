//
//  Bearer.swift
//  KidsFly
//
//  Created by Dillon P on 2/28/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation

struct Bearer: Codable {
    let token: String
    let message: String
}

struct Saved: Codable {
    let id: UInt
}

struct Message: Codable {
    let message: String
}
