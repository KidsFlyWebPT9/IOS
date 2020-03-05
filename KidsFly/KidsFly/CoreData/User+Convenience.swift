//
//  User+Convenience.swift
//  KidsFly
//
//  Created by dillon on 3/4/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    @discardableResult convenience init(id: Int16,
                                        username: String,
                                        password: String,
                                        image: String,
                                        name: String,
                                        address: String,
                                        airportId: String,
                                        phone: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.id = id
        self.username = username
        self.password = password
        self.image = image
        self.name = name
        self.address = address
        self.airportId = airportId
        self.phone = phone
    }

    @discardableResult convenience init?(userRepresentation: UserRepresentation, context: NSManagedObjectContext) {
        
        guard let id = userRepresentation.id,
            let image = userRepresentation.image,
            let name = userRepresentation.name,
            let address = userRepresentation.address,
            let phone = userRepresentation.phone,
            let airportId = userRepresentation.airportId else { return nil }
        
        self.init(id: id, username: userRepresentation.username, password: userRepresentation.password, image: image, name: name, address: address, airportId: airportId, phone: phone)
    }

    var userRepresentation: UserRepresentation? {
        guard let username = username,
            let password = password else { return nil }
        return UserRepresentation(id: id, username: username, password: password, image: image, name: name, address: address, airportId: airportId, phone: phone)
    }
    
    // END
}
