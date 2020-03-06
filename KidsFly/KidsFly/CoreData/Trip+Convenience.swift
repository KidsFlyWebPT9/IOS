//
//  Trip+Convenience.swift
//  KidsFly
//
//  Created by dillon on 3/4/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation
import CoreData

extension Trip {
    
//    enum CodingKeys: String, CodingKey {
//        case userId = "user_id"
//        case airportId = "airport_id"
//        case workerId = "worker_id"
//        case flightNumber = "flight_number"
//        case departureTime = "departure_time"
//        case special_needs = "special_needs"
//    }
    
    @discardableResult convenience init(id: Int16,
                                        user_id: Int16,
                                        airport_id: Int16,
                                        worker_id: Int16,
                                        airline: String,
                                        flight_number: String,
                                        departure_time: String,
                                        luggage: Int16,
                                        children: Int16,
                                        special_needs: String,
//                                        approved: Int16,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.id = id
        self.user_id = user_id
        self.airport_id = airport_id
        self.worker_id = worker_id
        self.airline = airline
        self.flight_number = flight_number
        self.departure_time = departure_time
        self.luggage = luggage
        self.children = children
        self.special_needs = special_needs
//        self.approved = approved
    }
    
    @discardableResult convenience init?(tripRepresentation: TripRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let id = tripRepresentation.id,
            let worker_id = tripRepresentation.worker_id,
            let airline = tripRepresentation.airline,
            let flight_number = tripRepresentation.flight_number,
            let luggage = tripRepresentation.luggage,
            let children = tripRepresentation.children,
            let special_needs = tripRepresentation.special_needs else { return nil }
        
        self.init(id: id, user_id: tripRepresentation.user_id, airport_id: tripRepresentation.airport_id, worker_id: worker_id,  airline: airline, flight_number: flight_number, departure_time: tripRepresentation.departure_time, luggage: luggage, children: children, special_needs: special_needs)
    }
    
    var tripRepresentation: TripRepresentation? {
        guard let departure_time = departure_time else { return nil }
        return TripRepresentation(id: id, user_id: user_id, airport_id: airport_id, worker_id: worker_id, airline: airline, departure_time: departure_time, luggage: luggage, children: children, special_needs: special_needs)
    }
    
    
}
