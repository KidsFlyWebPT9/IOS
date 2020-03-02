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

//    private let baseURL = URL(string: "https://test.api.amadeus.com/v1/")!
    private let apiAuthURL = URL(string: "https://test.api.amadeus.com/v1/security/oauth2/token")!
    private let clientId = "09pengtH6hfWAafoF4nOsQCt05V0At3i"
    private let clientKey = "oYeCs1KpGFJ8YYFm"
    let keychain = Keychain()
    
    
    func searchForAirport(completion: @escaping (Error?) -> Void) {
        
        guard let accessToken = keychain["airport_access_token"] else {
            completion(nil)
            return
        }
        
        let airportURLString = "https://test.api.amadeus.com/v1/reference-data/locations?subType=AIRPORT,CITY&keyword=san%20fran"
        let requestURL = URL(string: airportURLString)!
        
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
    
    
    
}
