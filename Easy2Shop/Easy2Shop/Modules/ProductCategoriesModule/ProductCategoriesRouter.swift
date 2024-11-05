//
//  ProductCategoriesRouter.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 04.11.24.
//

import Foundation

@objc protocol ProductCategoriesRoutingLogic {}

protocol ProductCategoriesDataPassing {}

final class ProductCategoriesRouter: NSObject {
    
    // MARK: - Public Properties
    
    weak var viewController: ProductCategoriesViewController?
    var dataStore: ProductCategoriesDataStore?
}

extension ProductCategoriesRouter: ProductCategoriesRoutingLogic {
}

extension ProductCategoriesRouter: ProductCategoriesDataPassing {
}
