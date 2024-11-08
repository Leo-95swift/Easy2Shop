//
//  BasketWorkers.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 08.11.24.
//

import Foundation

class BasketWorker {
    
    func getFavoriteProductIds() -> [Int] {
        var favoriteProductIds: [Int] = []
        if let productIds = UserDefaults.standard.array(forKey: "selectedProducts") {
            favoriteProductIds = productIds.map({ $0 as? Int ?? 0 })
        }
        
        return favoriteProductIds
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
