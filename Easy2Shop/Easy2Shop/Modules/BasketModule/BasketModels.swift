//
//  BasketModels.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 08.11.24.
//

import UIKit

enum Basket {
    // MARK: Use cases
    
    enum DisplayBasket {
        struct Request {
        }
        
        struct Response {
            struct ProductInformationModel {
                let id: Int
                let productImage: UIImage
                let productRating: Double
                let productName: String
                let productPrice: Double
                let productDescription: String
            }
        }
        
        struct ViewModel {
            struct ProductInformationModel {
                let id: Int
                let productImage: UIImage
                let productRating: Double
                let productName: String
                let productPrice: Double
                let productDescription: String
            }
            var products: [ProductInformationModel]
        }
    }
}

