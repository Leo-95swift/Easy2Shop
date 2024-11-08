//
//  ProductsRouter.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 05.11.24.
//

import UIKit

@objc protocol ProductsRoutingLogic {
}

protocol ProductsDataPassing {
    var dataStore: ProductsDataStore? { get }
}

final class ProductsRouter: NSObject, ProductsRoutingLogic, ProductsDataPassing {
    weak var viewController: ProductsViewController?
    var dataStore: ProductsDataStore?
}
