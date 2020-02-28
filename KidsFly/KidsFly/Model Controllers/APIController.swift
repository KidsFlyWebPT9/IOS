//
//  APIController.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

struct HTTPMethod {
    static let get = "GET"
    static let put = "PUT"
    static let post = "POST"
    static let delete = "DELETE"
}

class APIController {
    
    
    
}
