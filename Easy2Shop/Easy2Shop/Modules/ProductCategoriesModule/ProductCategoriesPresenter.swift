//
//  ProductCategoriesPresenter.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 04.11.24.
//

import UIKit

protocol ProductCategoriesPresentationLogic {
   
    /// для получения названий категорий
    func presentFetchedProductCategories(
        response: ProductCategories.DisplayProductCategories.Response
    )
}

final class ProductCategoriesPresenter {
    
    // MARK: Public properties
    
    weak var viewController: ProductCategoriesDisplayLogic?
}

extension ProductCategoriesPresenter: ProductCategoriesPresentationLogic {
    
    func presentFetchedProductCategories(
        response: ProductCategories.DisplayProductCategories.Response
    ) {
        
        let categories = response.categories
        let viewModel = ProductCategories.DisplayProductCategories.ViewModel(
            categories: categories
        )
        viewController?.addCategoriesToVariable(viewModel: viewModel)
    }
}
