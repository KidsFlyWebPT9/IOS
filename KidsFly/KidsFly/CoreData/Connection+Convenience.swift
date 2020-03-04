import Foundation
import CoreData

extension Connection {
    
    
    // MARK: - Initializers
    
    /// Creates Parent with same Managed Object Contect "moc"
    @discardableResult
    convenience init(username: String,
                     password: String,
                     lastName: String,
                     identifier: UUID? = UUID(),
                     homeAirport: String,
                     firstName: String,
                     address: String,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.username = username
        self.password = password
        self.lastName = lastName
        self.identifier = identifier
        self.homeAirport = homeAirport
        self.firstName = firstName
        self.address = address
    }
    
//    /// Creates Connection from ConnectionRepresentation Data (Firebase JSON data)
//    @discardableResult
//    convenience init?(connectionRepresentation: ConnectionRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
//
//        guard let identifierString = connectionRepresentation.identifier,
//            let identifier = UUID(uuidString: identifierString) else { return nil }
//
//        self.init(context: context,
//                  username = connectionRepresentation.username,
//                  password = connectionRepresentation.password,
//                  lastName = connectionRepresentation.lastName,
//                  identifier = connectionRepresentation.identifier,
//                  homeAirport = connectionRepresentation.homeAirport,
//                  firstName = connectionRepresenation.firstName,
//                  address = connectionRepresenation.address)
//    }
//
//
//    // MARK: - Objects
//
//    /// Object used to pass Connections back and forward to Firebase in .JSON format
//    var connectionRepresenation: ConnectionRepresenation? {
//        guard let identifier = identifier else { return nil }
//
//        #warning("not Complete")
//        return ConnectionRepresentation(
//    }
}
