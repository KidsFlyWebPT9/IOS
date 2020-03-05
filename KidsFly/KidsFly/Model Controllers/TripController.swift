//
//  TripController.swift
//  KidsFly
//
//  Created by Dillon P on 3/3/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//


import Foundation
import CoreData

struct TripRepresentation: Codable {
    var airport: String
    var airline: String
    var departureTime: Date
    var numberOfChildren: Int
    var isArriving: Int = 0
}

class TripController {
    
    private let tempBaseURL = URL(string: "https://kidsfly2-e7707.firebaseio.com/trip")!
    
    func createNewTrip(_ trip: TripRepresentation, completion: @escaping (Error?) -> Void) {
        // A "POST" method requiring 1.) airport, 2.) airline, 3. departure_Time, 4. kids, 5. is_arriving (default value of 0)
        
        var request = URLRequest(url: tempBaseURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethod.post
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(trip)
            request.httpBody = data
        } catch {
            print(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
        
        
    }
    
    func getAllTrips(forUser: User?, withToken: String?, completion: @escaping (Error?) -> Void) {
        // A "GET" method to retreive all trips for a specific user.
    }
    
    
    func getSingleTrip(trip: TripRepresentation, forUser: User, completion: @escaping (Error?) -> Void) {
        
    }
    
    
    func updateTrip(withTrip: TripRepresentation, forUser: User, completion: @escaping (Error?) -> Void) {
        
    }
    
    
    func deleteTrip(trip: TripRepresentation, forUser: User, completion: @escaping (Error?) -> Void) {
        
    }
    
    
    func userIsArriving(forTrip: TripRepresentation, completion: @escaping (Error?) -> Void) {
        // A "PUT" method for a specific trip that only changes the "is_arriving" attribute from 0 -> 1
    }
    
    
    func userHasArrived(forTrip: TripRepresentation, completion: @escaping (Error?) -> Void) {
        // A "PUT" method for a specific trip that only changes the "is_arriving" attribute from 1 -> 0
        
    }
    
    
    
}

