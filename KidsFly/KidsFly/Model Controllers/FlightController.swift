//
//  FlightController.swift
//  KidsFly
//
//  Created by Dillon P on 3/1/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation
import KeychainAccess
// Networking Controller to access the Amadeus API with all airport, airline and flight details

class FlightController {

    private let baseSearchURLString = "https://test.api.amadeus.com/v1/reference-data/locations?subType=AIRPORT,CITY&keyword="
    private let apiAuthURL = URL(string: "https://test.api.amadeus.com/v1/security/oauth2/token")!
    private let clientId = "09pengtH6hfWAafoF4nOsQCt05V0At3i"
    private let clientKey = "oYeCs1KpGFJ8YYFm"
    private let airportURL = URL(string: "https://kidsfly1.herokuapp.com/api/airports")!
    let keychain = Keychain()
    
    var airportDatabase = [String : Int]()
    var airport: AirportData?
    
    func searchForAirport(airportName: String, completion: @escaping (Error?) -> Void) {
        
        getAccessToken { (error) in
            if let error = error {
                print("Error getting access token: \(error)")
                completion(error)
                return
            }
            
            guard let accessToken = self.keychain["airport_access_token"] else {
                print("Error: No airport API access token")
                completion(NetworkError.noAuth)
                return
            }
            
            let searchTerm = airportName.replacingOccurrences(of: " ", with: "%20")
            let aiportURLString = self.baseSearchURLString + searchTerm + "&view=LIGHT&page[limit]=1"
            let requestURL = URL(string: aiportURLString)!
            var request = URLRequest(url: requestURL)
            //            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            request.httpMethod = HTTPMethod.get
            
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    print("Error occured while fetching aiport info: \(error)")
                    completion(error)
                    return
                }
                guard let data = data else {
                    print("No data returned from request")
                    completion(NetworkError.badData)
                    return
                }
                // TO-DO: Intermediate codable with coding keys for the returned json data
                print(data)
                
                let decoder = JSONDecoder()
                
                do {
                    let airports = try decoder.decode(AirportSearchResponse.self, from: data)
                    if airports.data.count == 0 {
                        completion(nil)
                        return
                    } else {
                        let airport = airports.data[0]
                        print(airport)
                        self.airport = airport
                    }
                } catch {
                    print("Error decoding Airport data: \(error)")
                    completion(error)
                    return
                }
                
                completion(nil)
            }.resume()
        }
    }
    
    
    func getAccessToken(completion: @escaping (Error?) -> Void) {
        let postData = NSMutableData(data: "grant_type=client_credentials&client_id=\(clientId)&client_secret=\(clientKey)".data(using: String.Encoding.utf8)!)
        var request = URLRequest(url: apiAuthURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethod.post
        request.httpBody = postData as Data
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error with data task: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                print("Error with Amadeus API response data")
                completion(NetworkError.badData)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let authResponse = try decoder.decode(AirportAuthResponse.self, from: data)
                self.keychain["airport_access_token"] = authResponse.access_token
                print(authResponse)
            } catch {
                print("Error decoding Airport Auth Data: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    
    func getFullAirportDatabase(completion: @escaping (Error?) -> Void) {
        
        var request = URLRequest(url: airportURL)
        request.httpMethod = HTTPMethod.get
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error getting Airport Database: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let airports = try decoder.decode([Airport].self, from: data)
                var counter = 0
                for airport in airports {
                    self.airportDatabase[airport.iata_code] = counter
                    counter += 1
                }
            } catch {
                print("Error decoding airport database: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func getIndex(airport: String, completion: @escaping (Error?) -> Void) {
        print(airportDatabase[airport])
        completion(nil)
    }
    
    
}
