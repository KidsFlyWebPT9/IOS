//
//  AirportAPIResponse.swift
//  KidsFly
//
//  Created by Dillon P on 3/1/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation

struct AirportAuthResponse: Codable {
    let type: String
    let username: String
    let application_name: String
    let client_id: String
    let token_type: String
    let access_token: String
    let expires_in: Int
    let state: String
    let scope: String
}

struct AirportSearchResponse: Codable {
    
}
