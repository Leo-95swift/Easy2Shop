//
//  ProductCategoriesRouter.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 04.11.24.
//

import Foundation

@objc protocol ProductCategoriesRoutingLogic {
    
    /// для перехода на экран продуктов данной категории
    func routeToProductsViewController()
}

protocol ProductCategoriesDataPassing {
    
    var dataStore: ProductCategoriesDataStore? { get }
}

final class ProductCategoriesRouter: NSObject, ProductCategoriesRoutingLogic, ProductCategoriesDataPassing  {
    
// MARK: - Public Properties
    
    weak var viewController: ProductCategoriesViewController?
    var dataStore: ProductCategoriesDataStore?

    // MARK: Routing

    func routeToProductsViewController() {
        
        let destinationVC = ProductsViewController()
        
        guard let dataStore = dataStore,
                var destinationDS = destinationVC.router?.dataStore,
                 let viewController = viewController
        else { return }
        
        passDataToSomewhere(source: dataStore, destination: &destinationDS)
        navigateToSomewhere(source: viewController, destination: destinationVC)

    }
    
    func navigateToSomewhere(
        source: ProductCategoriesViewController,
        destination: ProductsViewController
    ) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data

    func passDataToSomewhere(
        source: ProductCategoriesDataStore,
        destination: inout ProductsDataStore
    ) {
        destination.categoryName = source.chosenCategory

    }
}
