//
//  NetworkService.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 05.11.24.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    private let baseURL = "https://dummyjson.com"
    
    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        let endpoint = "/products/category-list"
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -2, userInfo: nil)))
                return
            }
            
            do {
                let categories = try JSONDecoder().decode([String].self, from: data)
                completion(.success(categories))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}