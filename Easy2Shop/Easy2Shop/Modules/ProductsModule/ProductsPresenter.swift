//
//  ProductsPresenter.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 05.11.24.
//

import UIKit

protocol ProductsPresentationLogic {
   
    /// для получения названий категорий
    func presentFetchedProducts(
        response: [Products.DisplayProducts.Response.ProductInformationModel]
    )
}

final class ProductsPresenter {
    
    // MARK: Public properties
    
    weak var viewController: ProductsDisplayLogic?
}

extension ProductsPresenter: ProductsPresentationLogic {
    
    func presentFetchedProducts(
        response: [Products.DisplayProducts.Response.ProductInformationModel]
    ) {
        
        let productInfoArray = response
        
        var productInformation: [Products.DisplayProducts.ViewModel.ProductInformationModel] = []
        
     
        for productInfo in productInfoArray {
            let productModel = Products.DisplayProducts.ViewModel.ProductInformationModel(
                productImage: productInfo.productImage,
                productRating: productInfo.productRating,
                productName: productInfo.productName,
                productPrice: productInfo.productPrice,
                productDescription: productInfo.productDescription
            )
            
            productInformation.append(productModel)
        }
        
        let viewModel = Products.DisplayProducts.ViewModel(products: productInformation)
        viewController?.addProductsToVariable(viewModel: viewModel)
    }
}

