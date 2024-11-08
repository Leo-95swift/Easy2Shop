//
//  BasketPresenter.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 08.11.24.
//

import UIKit

protocol BasketPresentationLogic {
   
    /// для получения названий категорий
    func presentFetchedProducts(
        response: [Basket.DisplayBasket.Response.ProductInformationModel]
    )
}

final class BasketPresenter {
    
    // MARK: Public properties
    
    weak var viewController: BasketDisplayLogic?
}

extension BasketPresenter: BasketPresentationLogic {
    
    func presentFetchedProducts(
        response: [Basket.DisplayBasket.Response.ProductInformationModel]
    ) {
        
        let productInfoArray = response
        
        var productInformation: [Basket.DisplayBasket.ViewModel.ProductInformationModel] = []
        
        for productInfo in productInfoArray {
            let productModel = Basket.DisplayBasket.ViewModel.ProductInformationModel(
                id: productInfo.id,
                productImage: productInfo.productImage,
                productRating: productInfo.productRating,
                productName: productInfo.productName,
                productPrice: productInfo.productPrice,
                productDescription: productInfo.productDescription
            )
            
            productInformation.append(productModel)
        }
        
        let viewModel = Basket.DisplayBasket.ViewModel(products: productInformation)
        viewController?.addProductToVariable(viewModel: viewModel)
    }
}

