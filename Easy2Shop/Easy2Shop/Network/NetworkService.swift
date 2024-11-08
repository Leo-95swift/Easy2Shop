//
//  NetworkService.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 05.11.24.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    
    /// для получения одного конкретного продуктa
    func fetchSingleProduct(
        productId: Int,
        completion: @escaping (Result<ProductDTO, Error>) -> Void
    )
    
    /// для получения списка продуктов данной категории
    func fetchProducts(
        completion: @escaping (Result<ProductsResultDTO, Error>) -> Void
    )
    
    /// для получения картинки по URL адресу
    func loadImage(
        for url: URL,
        completion: @escaping (Result<UIImage, Error>) -> Void
    )
}

class NetworkService: NetworkServiceProtocol {
    
    private let baseURL = "https://dummyjson.com"
    
    func fetchSingleProduct(
        productId: Int,
        completion: @escaping (Result<ProductDTO, any Error>) -> Void
    ) {
        let endpoint = "/product/\(productId)"
        
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
                let product = try JSONDecoder()
                    .decode(ProductDTO.self, from: data)
                completion(.success(product))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
    
    func fetchProducts(
        completion: @escaping (Result<ProductsResultDTO, any Error>) -> Void
    ) {
        let endpoint = "/products"
        
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
                let productsInfo = try JSONDecoder()
                    .decode(ProductsResultDTO.self, from: data)
                completion(.success(productsInfo))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
    
    func loadImage(for url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(
            with: urlRequest,
            completionHandler: { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }

                guard response.statusCode == 200 else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }

                guard let data = data, let image = UIImage(data: data) else {
                    completion(.failure(URLError(.cannotDecodeContentData)))
                    return
                }

                completion(.success(image))
            }
        )
        task.resume()
    }
}
