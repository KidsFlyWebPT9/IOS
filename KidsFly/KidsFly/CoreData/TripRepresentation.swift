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
    var id: Int16?
    var userId: Int16
    var airportId: String
    var workerId: Int16?
    var airline: String?
    var departureTime: Date
    var luggage: Int16?
    var children: Int16?
    var specialNeeds: String?
}
