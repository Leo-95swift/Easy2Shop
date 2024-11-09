//
//  ProductsWorker.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 05.11.24.
//

import Foundation

class ProductsWorker {
    
    func getFavoriteProductIds() -> [Int] {
        var favoriteProductIds: [Int] = []
        if let productIds = UserDefaults.standard.array(forKey: "selectedProducts") {
            favoriteProductIds = productIds.map({ $0 as? Int ?? 0 })
        }
        
        return favoriteProductIds
    }
    
    func saveProductIdInFavorites(_ productId: Int) {
        var selectedProductIds = UserDefaults.standard
            .array(forKey: "selectedProducts") ?? []
        
        if !selectedProductIds.contains(where: { $0 as! Int == productId }) {
            selectedProductIds.append(productId)
            UserDefaults.standard
                .setValue(selectedProductIds, forKey: "selectedProducts")
        }
    }
    
    func removeProdductIdFromFavorites(_ productId: Int) {
        var currentSelectedProductIds = UserDefaults.standard
            .array(forKey: "selectedProducts") ?? []
        
        var modifiedSelectedProductIds = currentSelectedProductIds
            .filter { $0 as? Int ?? 0 != productId }

        UserDefaults.standard
            .setValue(modifiedSelectedProductIds, forKey: "selectedProducts")
    }
    
}
