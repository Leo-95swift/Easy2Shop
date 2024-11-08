//
//  ProductsModels.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 05.11.24.
//

import UIKit

enum Products {
    // MARK: Use cases
    
    enum DisplayProducts {
        struct Request {
        }
        
        struct Response {
            struct ProductInformationModel {
                let productImage: UIImage
                let productRating: Double
                let productName: String
                let productPrice: Double
                let productDescription: String
            }
//            var products: [ProductInformationModel]
        }
        
        struct ViewModel {
            struct ProductInformationModel {
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
