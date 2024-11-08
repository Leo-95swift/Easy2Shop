//
//  ProductsInteractor.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 05.11.24.
//

import UIKit

protocol ProductsBusinessLogic {
    
    func fetchProducts(
        request: Products.DisplayProducts.Request
    )
}

protocol ProductsDataStore {
    var categoryName: String? { get set }
}

final class ProductsInteractor: ProductsBusinessLogic, ProductsDataStore {
    
    // MARK: Constants
    
    private let networkService: NetworkServiceProtocol = NetworkService()
    
    // MARK: Public properties
    
    var categoryName: String?
    var presenter: ProductsPresentationLogic?
    var worker: ProductsWorker?
    var products: [Products.DisplayProducts.ViewModel.ProductInformationModel] = []
    
    // MARK: Public methods
    
    func fetchProducts(request: Products.DisplayProducts.Request) {
        
        guard let categoryName = categoryName, !categoryName.isEmpty
        else {
            return
        }
        
        networkService.fetchProducts(categoryName: categoryName) { result in
            switch result {
            case .success(let productInfoResult):
                
                let dispatchGroup = DispatchGroup()
                var productsArray: [Products.DisplayProducts.Response.ProductInformationModel] = []
                
                for productInfo in productInfoResult.products {
                    dispatchGroup.enter()
                    
                    let imageString = productInfo.images[0]
                    guard let url = URL(string: imageString) else {
                        return
                    }
                    self.networkService.loadImage(for: url) { result in
                            switch result {
                            case .success(let fetchedImage):
                                
                                let newItem = Products.DisplayProducts.Response.ProductInformationModel(
                                    productImage: fetchedImage,
                                    productRating: productInfo.rating,
                                    productName: productInfo.title,
                                    productPrice: productInfo.price,
                                    productDescription: productInfo.description
                                )
                                productsArray.append(newItem)
                                dispatchGroup.leave()
                            case .failure(_):
                                break
                            }
                        }
                }
                
                dispatchGroup.notify(queue: .main) {
                    self.presenter?.presentFetchedProducts(response: productsArray)
                }
                
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
            }
        }

    }
    
}