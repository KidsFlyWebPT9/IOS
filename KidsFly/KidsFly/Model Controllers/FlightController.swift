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
    private let airportURL = URL(string: "https://kidsfly3.herokuapp.com/api/airports")!
    var accessToken: String?
    let keychain = Keychain()
    
    var persistentAirportURL: URL? {
        let fileManager = FileManager.default
        // Find documents directory of the app
        guard let docuemntsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let airportDBUrl = docuemntsDir.appendingPathComponent("airports.plist")
        return airportDBUrl
    }
    
    var iataCode: String?
    var airportID: Int?
    var airportDatabase = [String : Int]()
    var airport: AirportData?
    
    func searchForAirport(airportName: String, completion: @escaping (Error?) -> Void) {
        
        guard let accessToken = self.keychain["airport_access_token"] else {
            print("Error: No airport API access token")
            completion(nil)
            return
        }
        
        let searchTerm = airportName.replacingOccurrences(of: " ", with: "%20")
        let aiportURLString = self.baseSearchURLString + searchTerm + "&page[limit]=1"
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
                    self.iataCode = airport.iataCode
                    // Discovered that Amadeus API returns local Chicago airport before chicago midway
                    self.airportID = self.getIndex(using: airport.iataCode)
                    
                    print(self.airportID ?? 1)
                }
            } catch {
                print("Error decoding Airport data: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
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
                self.saveAirportsToPersistentStore()
            } catch {
                print("Error decoding airport database: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func getIndex(using airportCode: String) -> Int? {
        loadAirportsFromPersitentStore()
        guard let airportIndex = airportDatabase[airportCode] else {
            return nil
        }
        self.airportID = airportIndex
        return airportIndex
    }
    
    func getAirportCode(using airportID: Int) -> String? {
        loadAirportsFromPersitentStore()
        let airportCode = airportDatabase.keysForValue(value: airportID)[0]
        return airportCode
    }
    
    func saveAirportsToPersistentStore() {
        guard let fileURL = persistentAirportURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let airportData = try encoder.encode(airportDatabase)
            try airportData.write(to: fileURL)
        } catch {
            print("Error encoding Airport Database: \(error)")
        }
    }
    
    func loadAirportsFromPersitentStore() {
        guard let fileURL = persistentAirportURL else { return }
        
        do {
            let airportData = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            let airportDB = try decoder.decode([String : Int].self, from: airportData)
            self.airportDatabase = airportDB
        } catch {
            print("Error decoding Airport Database; \(error)")
        }
    }
    
}

extension Dictionary where Value: Equatable {
    func keysForValue(value: Value) -> [Key] {
        return compactMap { (key: Key, val: Value) -> Key? in
            value == val ? key : nil
        }
    }
}
