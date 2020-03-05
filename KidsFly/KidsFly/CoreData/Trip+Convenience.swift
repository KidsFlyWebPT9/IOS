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
    
    @discardableResult convenience init(id: Int16,
                                        userId: Int16,
                                        airportId: String,
                                        workerId: Int16,
                                        airline: String,
                                        departureTime: Date,
                                        luggage: Int16,
                                        children: Int16,
                                        specialNeeds: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.id = id
        self.userId = userId
        self.airportId = airportId
        self.workerId = workerId
        self.airline = airline
        self.departureTime = departureTime
        self.luggage = luggage
        self.children = children
        self.specialNeeds = specialNeeds
    }
    
    @discardableResult convenience init?(tripRepresentation: TripRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let id = tripRepresentation.id,
            let workerId = tripRepresentation.workerId,
            let airline = tripRepresentation.airline,
            let luggage = tripRepresentation.luggage,
            let children = tripRepresentation.children,
            let specialNeeds = tripRepresentation.specialNeeds else { return nil }
        
        self.init(id: id, userId: tripRepresentation.userId, airportId: tripRepresentation.airportId, workerId: workerId,  airline: airline, departureTime: tripRepresentation.departureTime, luggage: luggage, children: children, specialNeeds: specialNeeds)
    }
    
    var tripRepresentation: TripRepresentation? {
        guard let airportId = airportId,
        let departureTime = departureTime else { return nil }
        return TripRepresentation(id: id, userId: userId, airportId: airportId, workerId: workerId, airline: airline, departureTime: departureTime, luggage: luggage, children: children, specialNeeds: specialNeeds)
    }
    
    
}
