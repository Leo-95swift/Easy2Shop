//
//  CategoryResult.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 04.11.24.
//

import Foundation

struct CategoryResult {
    
    /// список названий для категорий товаров
    let categoryNames: [String]
}

struct ProductCategory {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

struct Product {
    let id: Int
    let title: String
}
