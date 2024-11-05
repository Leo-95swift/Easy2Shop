//
//  ProductCategoriesModels.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 04.11.24.
//

import UIKit

enum ProductCategories {
    // MARK: Use cases
    
    enum DisplayProductCategories {
        struct Request {
        }
        
        struct Response {
            let categories: [String]
        }
        
        struct ViewModel {
            var categories: [String]
        }
    }
}
