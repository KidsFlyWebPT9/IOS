//
//  TravelerController.swift
//  KidsFly
//
//  Created by Dillon P on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation
import KeychainAccess
import CoreData


class TravelerController {
    
    let keychain = Keychain(service: "com.kidsfly.app")
    var welcomeMessage: String?
    private let baseURL = URL(string: "https://kidsfly3.herokuapp.com/")!
    
    var currentUser: User?
    var currentUserRep: UserRepresentation?
    
    // CREATE User
    func registerNewUser(user: User, completion: @escaping (Error?) -> Void) {
        let registerNewUserURL = baseURL.appendingPathComponent("api/auth/register")
        
        var request = URLRequest(url: registerNewUserURL)
        request.httpMethod = HTTPMethod.post
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(user.userRepresentation)
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
                print("HTTP Response error when attempting to register new user: \(response.statusCode)")
                completion(NetworkError.otherError)
                return
            }
            guard let data = data else {
                print("Error with returned data for user registration")
                completion(NetworkError.badData)
                return
            }
            let decoder = JSONDecoder()
            do {
                let userRep = try decoder.decode(UserRepresentation.self, from: data)
                if let userID = userRep.id {
                    self.keychain["user_id"] = "\(userID)"
                    print("Successfully created user with ID: \(userID)")
                }
            } catch {
                completion(NetworkError.noDecode)
                print("Error decoding user information")
            }
            completion(nil)
        }.resume()
    }
    
    
    // READ User
    func signIn(user: User, completion: @escaping (Error?) -> Void) {
        let signInURL = baseURL.appendingPathComponent("api/auth/login")
        
        var request = URLRequest(url: signInURL)
        request.httpMethod = HTTPMethod.post
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(user.userRepresentation)
            request.httpBody = data
        } catch {
            print("Error encoding data: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                print("HTML Response code returned: \(response.statusCode)")
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            if let error = error {
                print("Error logging in: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                print("Error with returned data")
                completion(NetworkError.badData)
                return
            }
            let decoder = JSONDecoder()
            do {
                let bearer = try decoder.decode(Bearer.self, from: data)
                let token = bearer.token
                self.keychain["user_token"] = "\(token)"
                print(token)
            } catch {
                print("Error decoding bearer object: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    
    // READ User
    func getUserInfo(completion: @escaping (Error?) -> Void) {
        guard let userID = keychain["user_id"], let token = keychain["user_token"] else { return }
        let welcomeMessageURL = self.baseURL.appendingPathComponent("api/users/\(userID)")
        var request = URLRequest(url: welcomeMessageURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
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
                print("Error with returned data")
                completion(NetworkError.badData)
                return
            }
            let decoder = JSONDecoder()
            print(data)
            do {
                let userRep = try decoder.decode(UserRepresentation.self, from: data)
//                self.keychain["userInformation"] = String(data: data, encoding: .iso2022JP)
                self.currentUserRep = userRep
            } catch {
                print("Error decoding user data")
                completion(NetworkError.noDecode)
                return
            }
            completion(nil)
        }.resume()
    }
    
    // UPDATE User
    func updateUser(user: UserRepresentation, completion: @escaping (Error?) -> Void) {
        
        guard let userID = self.keychain["user_id"], let userToken = self.keychain["user_token"] else { return }
        let updateUserURL = baseURL.appendingPathComponent("api/users/\(userID)")
        
        var request = URLRequest(url: updateUserURL)
        request.httpMethod = HTTPMethod.put
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(userToken, forHTTPHeaderField: "Authorization")
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(user)
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
            response.statusCode != 200 {
                print("HTTP Response error when attempting to edit new user: \(response.statusCode)")
                completion(NetworkError.otherError)
                return
            }
            guard let data = data else {
                print("Error with returned data for user registration")
                completion(NetworkError.badData)
                return
            }
            let decoder = JSONDecoder()
            do {
                let userRep = try decoder.decode(UserRepresentation.self, from: data)
                if let userID = userRep.id {
                    self.keychain["user_id"] = "\(userID)"
                    print("Successfully updated user with ID: \(userID)")
                }
                self.currentUserRep = userRep
//                if let _ = self.convertToUser(userRep: userRep) {
//                    self.saveToPersistentStore()
//                }
            } catch {
                completion(NetworkError.noDecode)
                print("Error decoding user information")
            }
            completion(nil)
        }.resume()
    }
    
    
    
    // This method only worked ont he original API that was abonded due to BackEnd not coming through
//    func getListOfAllTravellers(completion: @escaping (Error?) -> Void) {
//
//        guard let token = keychain["user_token"] else { return }
//        let usersURL = baseURL.appendingPathComponent("api/users")
//
//        var request = URLRequest(url: usersURL)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
//        request.httpMethod = HTTPMethod.get
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error getting user data: \(error)")
//                completion(error)
//                return
//            }
//            if let response = response as? HTTPURLResponse,
//                response.statusCode != 200 {
//                print("HTTPResponse status code returned: \(response.statusCode) with error: \(NetworkError.otherError) ")
//                completion(NetworkError.otherError)
//                return
//            }
//            guard let data = data else {
//                print("Error with returned data")
//                completion(NetworkError.badData)
//                return
//            }
//            let decoder = JSONDecoder()
//
//            do {
//                let users = try decoder.decode([UserRepresentation].self, from: data)
//                print(users)
//            } catch {
//                print("Error decoding all users data: \(NetworkError.noDecode)")
//                completion(error)
//                return
//            }
//            completion(nil)
//        }.resume()
//    }
//
    
    
    // MARK: - Core Data Methods
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
        } catch {
            print("Error saving data to persistent store: \(error)")
        }
    }
    
    func fetchUserInfo(completion: (Error?) -> Void) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        do {
            let user = try moc.fetch(fetchRequest)
            self.currentUser = user.last
            completion(nil)
        } catch {
            print("Error fetching user from persistent store: \(error)")
            completion(error)
        }
    }
    
    func convertToUser(userRep: UserRepresentation) -> User? {
        if let user = User(userRepresentation: userRep) {
            return user
        } else {
            return nil
        }
    }
    
    
}


