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
}
