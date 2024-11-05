//
//  ProductCategoriesInteractor.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 04.11.24.
//

protocol ProductCategoriesBusinessLogic {
    func fetchProductCategories(request: ProductCategories.DisplayProductCategories.Request)
    func saveSelectedItem(
        category: String
    )
}

protocol ProductCategoriesDataStore {
    var chosenCategory: String? { get set }
}

final class ProductCategoriesInteractor: ProductCategoriesBusinessLogic {
    
    // MARK: Constants
    
    private let networkService: NetworkServiceProtocol = NetworkService()
    
    // MARK: Public properties
    
    var presenter: ProductCategoriesPresentationLogic?
    var worker: ProductCategoriesWorker?
    var categories: [String] = []
    var chosenCategory: String?
    
    // MARK: Public methods
    
    func fetchProductCategories(request: ProductCategories.DisplayProductCategories.Request) {

        networkService.fetchCategories { result in
            switch result {
            case .success(let categories):
                self.categories = categories
                let response = ProductCategories.DisplayProductCategories.Response(
                    categories: categories)
                self.presenter?.presentFetchedProductCategories(response: response)
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
            }
        }

    }
    
    func saveSelectedItem(category: String) {
        chosenCategory = category
    }
}

extension ProductCategoriesInteractor: ProductCategoriesDataStore {
    
}
