//
//  TripController.swift
//  KidsFly
//
//  Created by Dillon P on 3/3/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//


import Foundation
import CoreData
import KeychainAccess


class TripController {
    
    let travelerController = TravelerController()
    
    private let baseURL = URL(string: "https://kidsfly1.herokuapp.com/")!
    
    
    func createNewTrip(_ trip: TripRepresentation, completion: @escaping (Error?) -> Void) {
        // "POST"
        let keychain = travelerController.keychain
        guard let id = keychain["user_id"], let token = keychain["user_token"] else { return }
        let requestURL = baseURL.appendingPathComponent("api/users/\(id)/newtrip")
        var request = URLRequest(url: requestURL)
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
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
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            guard let data = data else {
                print("Error with data returned")
                completion(NetworkError.badData)
                return
            }
            let decoder = JSONDecoder()
            do {
                let trip = try decoder.decode(TripRepresentation.self, from: data)
                print(trip)
            } catch {
                print("Error decoding trip data: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    func getAllTrips(completion: @escaping (Error?) -> Void) {
        // GET /api/:id/trips to get trips created by the user
        let keychain = travelerController.keychain
        guard let token = keychain["user_token"] else { return }
        
        let requestURL = baseURL.appendingPathComponent("api/trips")
        var request = URLRequest(url: requestURL)
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethod.get
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            guard let data = data else {
                print("Error getting data for all trips")
                completion(NetworkError.badData)
                return
            }
            
            let decoder = JSONDecoder()
            
           do {
                let trips = try decoder.decode([TripRepresentation].self, from: data)
                print(trips)
            } catch {
                print("Error decoding trip data: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    //
//    
//    func getSingleTrip(trip: TripRepresentation, forUser: User, completion: @escaping (Error?) -> Void) {
//
//    }
//
//
//    func updateTrip(withTrip: TripRepresentation, forUser: User, completion: @escaping (Error?) -> Void) {
//
//    }
//
//
//    func deleteTrip(trip: TripRepresentation, forUser: User, completion: @escaping (Error?) -> Void) {
//
//    }
//
//
//    func userIsArriving(forTrip: TripRepresentation, completion: @escaping (Error?) -> Void) {
//        // A "PUT" method for a specific trip that only changes the "is_arriving" attribute from 0 -> 1
//    }
//
//
//    func userHasArrived(forTrip: TripRepresentation, completion: @escaping (Error?) -> Void) {
//        // A "PUT" method for a specific trip that only changes the "is_arriving" attribute from 1 -> 0
//
//    }
    
    
    
}

