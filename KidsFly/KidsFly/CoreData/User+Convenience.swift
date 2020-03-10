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
    
    @discardableResult convenience init(
                                        id: Int16? = nil,
                                        username: String,
                                        password: String,
                                        image: String? = nil,
                                        name: String? = nil,
                                        address: String? = nil,
                                        airport_id: Int16? = nil,
                                        phone: String? = nil,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        if let id = id {
            self.id = id
        }
        self.username = username
        self.password = password
        self.image = image
        self.name = name
        self.address = address
        if let airport_id = airport_id {
            self.airport_id = airport_id
        }
        self.phone = phone
    }

    @discardableResult convenience init?(userRepresentation: UserRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let id = userRepresentation.id,
            let image = userRepresentation.image,
            let name = userRepresentation.name,
            let address = userRepresentation.address,
            let phone = userRepresentation.phone,
            let airport_id = userRepresentation.airport_id else { return nil }
        
        self.init(id: id, username: userRepresentation.username, password: userRepresentation.password, image: image, name: name, address: address, airport_id: airport_id, phone: phone)
    }

    var userRepresentation: UserRepresentation? {
        guard let username = username,
            let password = password else { return nil }
        return UserRepresentation(id: id, username: username, password: password, image: image, name: name, address: address, airport_id: airport_id, phone: phone)
    }
    
    // END
}
