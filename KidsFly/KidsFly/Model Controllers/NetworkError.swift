//
//  NetworkError.swift
//  KidsFly
//
//  Created by Dillon P on 2/29/20.
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
