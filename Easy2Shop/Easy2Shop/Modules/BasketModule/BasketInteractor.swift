//
//  BasketInteractor.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 08.11.24.
//

import UIKit

protocol BasketBusinessLogic {
    
    func fetchProducts(
        request: Basket.DisplayBasket.Request
    )
}

protocol BasketDataStore {
}

final class BasketInteractor: BasketBusinessLogic, BasketDataStore {
    
    // MARK: Constants
    
    private let networkService: NetworkServiceProtocol = NetworkService()
    
    // MARK: Public properties
    
    var presenter: BasketPresentationLogic?
    var worker: BasketWorker?
    var products: [Basket.DisplayBasket.ViewModel.ProductInformationModel] = []
    
    // MARK: Public methods
    
    func fetchProducts(request: Basket.DisplayBasket.Request) {
        guard let productIds = worker?.getFavoriteProductIds(),
              !productIds.isEmpty
        else { return }
        
        let dispatchGroup = DispatchGroup()
        var productsArray: [Basket.DisplayBasket.Response.ProductInformationModel] = []
        
        for productId in productIds {
            dispatchGroup.enter()
            
            networkService.fetchSingleProduct(productId: productId) { result in
                switch result {
                case .success(let product):
                    
                    let imageString = product.images[0]
                    guard let url = URL(string: imageString) else {
                        return
                    }
                    
                    self.networkService.loadImage(for: url) { result in
                        switch result {
                        case .success(let fetchedImage):
                            
                            let newItem = Basket.DisplayBasket.Response.ProductInformationModel(
                                id: product.id,
                                productImage: fetchedImage,
                                productRating: product.rating,
                                productName: product.title,
                                productPrice: product.price,
                                productDescription: product.description
                            )
                            productsArray.append(newItem)
                            dispatchGroup.leave()
                        case .failure(_):
                            break
                        }
                    }
                case .failure(let failure):
                    break
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.presenter?.presentFetchedProducts(response: productsArray)
        }
        
    }
    
}

