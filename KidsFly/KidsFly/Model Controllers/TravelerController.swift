//
//  TravelerController.swift
//  KidsFly
//
//  Created by Dillon P on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation

struct User: Codable {
    let username: String
    let password: String
}

class TravelerController {
    
    var token: String?
    var id: UInt?
    var welcomeMessage: String?
    
    private let baseURL = URL(string: "https://kidsfly-lambda2.herokuapp.com")!
    
    
    func registerNewUser(username: String, password: String, completion: @escaping (Error?) -> Void) {
        
        
        let newUser = User(username: username, password: password)
        let registerNewUserURL = baseURL.appendingPathComponent("api/auth/register")
        var request = URLRequest(url: registerNewUserURL)
        request.httpMethod = HTTPMethod.post
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(newUser)
            request.httpBody = data
        } catch {
            print("Error encoding data: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let error = error {
                print("Error registering new user: \(error)")
                completion(error)
                return
            }
            if let response = response as? HTTPURLResponse,
            response.statusCode != 201 {
                print("Error signing up user")
                completion(NetworkError.otherError)
                return
            }
            guard let data = data else {
                completion(NetworkError.badData)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let saved = try decoder.decode(Saved.self, from: data)
                self.id = saved.id
                print("Successfully created user with ID: \(String(describing: self.id))")
            } catch {
                completion(NetworkError.noDecode)
                print("Error decoding user ID")
            }
            
            completion(nil)
            
        }.resume()
        
    }
    
    
    func signIn(username: String, password: String, completion: @escaping (Error?) -> Void) {
        
        let user = User(username: username, password: password)
        let signInURL = baseURL.appendingPathComponent("api/auth/login")
        var request = URLRequest(url: signInURL)
        request.httpMethod = HTTPMethod.post
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(user)
            request.httpBody = data
        } catch {
            print("Error encoding data: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                print("Error logging in: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NetworkError.badData)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let bearer = try decoder.decode(Bearer.self, from: data)
                self.token = bearer.token
                print("Token is: \(String(describing: self.token))")
            } catch {
                print("Error decoding bearer object: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
            
        }.resume()
        
    }
    
    
    func getUserWelcomeNotification(uId: Int, uToken: String, completion: @escaping (Error?) -> Void) {
        
            
            let welcomeMessageURL = self.baseURL.appendingPathComponent("api/users/\(uId)")
            var request = URLRequest(url: welcomeMessageURL)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = HTTPMethod.get
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error)
                    completion(error)
                    return
                }
                
                if let response = response as? HTTPURLResponse,
                    response.statusCode != 200 {
                    print("HTML Response code returned: \(response.statusCode)")
                    completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                    return
                }
                
                guard let data = data else {
                    completion(NetworkError.badData)
                    return
                }
                
                let decoder = JSONDecoder()
                print(data)
                
                do {
                    let returnedMessage = try decoder.decode(String.self, from: data)
                    self.welcomeMessage = returnedMessage
                    print(self.welcomeMessage ?? "welcome user!")
                } catch {
                    print("Error decoding welcome message")
                    completion(NetworkError.noDecode)
                    return
                }
                
                completion(nil)
                
            }.resume()
    }
    
}


