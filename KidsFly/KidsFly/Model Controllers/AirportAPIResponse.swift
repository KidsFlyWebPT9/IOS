//
//  AirportAPIResponse.swift
//  KidsFly
//
//  Created by Dillon P on 3/1/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation

struct AirportAuthResponse: Codable {
    let access_token: String
}

struct AirportSearchResponse: Codable {
    var data: [AirportData]
}

struct AirportData: Codable {
    var name: String
    var iataCode: String
    var address: Address
}

struct Airport: Codable, Equatable {
    var iata_code: String
}

struct Address: Codable {
    var cityName: String
    var stateCode: String
}
