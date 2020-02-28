//
//  TravelerController.swift
//  KidsFly
//
//  Created by Dillon P on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation

struct NewUser: Codable {
    let email: String
    let password: String
}

class TravelerController {
    
    private let baseURL = URL(string: "https://kidsfly-lambda2.herokuapp.com/")!
    
    
    func registerNewUser(for email: String, with password: String, completion: @escaping (Error?) -> Void) {
        
        let newUser = NewUser(email: email, password: password)
        
        let registerNewUserURL = baseURL.appendingPathComponent("localhost:5000/api/auth/register")
        
        var request = URLRequest(url: registerNewUserURL)
        request.httpMethod = HTTPMethod.post
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(newUser)
            request.httpBody = data
        } catch {
            print("Error encoding data: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("Error registering new user: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
            
        }.resume()
    }
    
    
}
