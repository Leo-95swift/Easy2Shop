//
//  BasketViewController.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 08.11.24.
//

import UIKit

protocol BasketDisplayLogic: AnyObject {
    func addProductToVariable(viewModel: Basket.DisplayBasket.ViewModel)
}

final class BasketViewController: UIViewController, BasketDisplayLogic {
    
    // MARK: VIP variables
    
     var interactor: BasketBusinessLogic?
     var router: (NSObjectProtocol & BasketRoutingLogic & BasketDataPassing)?
    
    // MARK: - Visual Components
    
    private let basketView = BasketView()
    
    // MARK: - Private Properties
    
    private var selectedProducts: [Basket.DisplayBasket.ViewModel.ProductInformationModel] = []
    private var productsSum = 0.0
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        configureSubviews()
        setupComponents()
        setupBasketCollectionView()
        requestSelectedProducts()
        
    }

    // MARK: - Private Methods
    
    private func setupSubviews() {
        view.addSubviews([
            basketView
        ])
        view.backgroundColor = .white
    }
    
    private func configureSubviews() {
        configureBasketViewConstraints()
    }
        
    func setupComponents() {
        
        let interactor = BasketInteractor()
        
        let viewController = self
        let presenter = BasketPresenter()
        let worker = BasketWorker()
        let router = BasketRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
    }
    
    private func setupBasketCollectionView() {
        basketView.productsCollectionView.delegate = self
        basketView.productsCollectionView.dataSource = self
        basketView.productsCollectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.identifier
        )
    }
        
    private func requestSelectedProducts() {
        let request = Basket.DisplayBasket.Request()
        interactor?.fetchProducts(request: request)
    }
    
    func addProductToVariable(
        viewModel: Basket.DisplayBasket.ViewModel
    ) {
        let products = viewModel.products
        self.selectedProducts = products
        self.productsSum = selectedProducts.reduce(0.0) { $0 + $1.productPrice }
        self.basketView.payButton.setTitle("Pay $\(productsSum)", for: .normal)
        
        DispatchQueue.main.async {
            self.basketView.productsCollectionView.reloadData()
        }
    }
      
}

// MARK: - UITableViewDataSource

extension BasketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        selectedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.identifier,
            for: indexPath
        ) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        let product = selectedProducts[indexPath.row]
        
        let dataForCell = Products.DisplayProducts.ViewModel.ProductInformationModel(
            id: product.id,
            productImage: product.productImage,
            productRating: product.productRating,
            productName: product.productName,
            productPrice: product.productPrice,
            productDescription: product.productDescription
        )
        
        cell.configure(with: dataForCell)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BasketViewController: UICollectionViewDelegate {

}

// MARK: - BasketViewController + UICollectionViewDelegateFlowLayout

extension BasketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: 350,
            height: 120
        )
    }
}

/// Расширение для установки размеров и расположений визуальных компонентов

extension BasketViewController {
    private func configureBasketViewConstraints() {
        NSLayoutConstraint.activate([
            basketView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            basketView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            basketView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            basketView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}

