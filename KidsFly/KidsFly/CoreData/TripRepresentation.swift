//
//  TripRepresentation.swift
//  KidsFly
//
//  Created by dillon on 3/4/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation
import CoreData

struct TripRepresentation: Equatable, Codable {
//    var id: Int16?
    var user_id: Int16
    var airport_id: Int16
    var worker_id: Int16?
    var airline: String?
    var flight_number: String?
    var departure_time: String
    var luggage: Int16?
    var children: Int16?
    var special_needs: String?
//    var approved: Int16?
}
