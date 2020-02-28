//
//  NetworkDataLoader.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
    func loadData(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
}
