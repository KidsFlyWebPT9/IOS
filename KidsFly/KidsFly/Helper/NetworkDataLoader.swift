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
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void)
}


extension URLSession: NetworkDataLoader {
    
    func loadData(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            completion(data, error)
        }
        
        dataTask.resume()
    }
    
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            completion(data, error)
        }
        
        dataTask.resume()
    }
    
}


struct MockLoader: NetworkDataLoader {
    
    var data: Data?
    var error: Error?
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.global().async {
            completion(self.data, self.error)
        }
    }
    
    func loadData(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.global().async {
            completion(self.data, self.error)
        }
    }
    
}
