//
//  TravelerController.swift
//  KidsFly
//
//  Created by Dillon P on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation

struct User: Codable {
    let email: String
    let password: String
}

class TravelerController {
    
    private let baseURL = URL(string: "https://kidsfly-lambda2.herokuapp.com/")!
    
    
    func registerNewUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        
        let newUser = User(email: email, password: password)
        
        let registerNewUserURL = baseURL.appendingPathComponent("api/auth/register")
        
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
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        
        let user = User(email: email, password: password)
        
        let signInURL = baseURL.appendingPathComponent("api/auth/login")
        
        var request = URLRequest(url: signInURL)
        request.httpMethod = HTTPMethod.post
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(user)
            request.httpBody = data
        } catch {
            print("Error encoding data: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            
            if let error = error {
                print("Error logging in: \(error)")
                completion(error)
                return
            }
            
        }.resume()
        
        
    }
}
