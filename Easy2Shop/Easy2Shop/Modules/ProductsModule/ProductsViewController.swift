//
//  ProductsViewController.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 05.11.24.
//

import UIKit

protocol ProductsDisplayLogic: AnyObject {
    func addProductsToVariable(viewModel: Products.DisplayProducts.ViewModel)
}

final class ProductsViewController: UIViewController, ProductsDisplayLogic {
    
    // MARK: VIP variables
    
     var interactor: ProductsBusinessLogic?
     var router: (NSObjectProtocol & ProductsRoutingLogic & ProductsDataPassing)?
    
    // MARK: - Visual Components
    
    private let productsView = ProductsView()
    
    // MARK: - Private Properties
    
    private var products: [Products.DisplayProducts.ViewModel.ProductInformationModel] = []
        
    // MARK: - Initializer
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        configureSubviews()
        setupProductsCollectionView()
        requestProducts()
        
    }

    // MARK: - Private Methods
    
    private func setupSubviews() {
        view.addSubviews([
            productsView
        ])
        view.backgroundColor = .white
    }
    
    private func configureSubviews() {
        configureProductsViewConstraints()
    }
        
    func setupComponents() {
        
        let interactor = ProductsInteractor()
        
        let viewController = self
        let presenter = ProductsPresenter()
        let router = ProductsRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        print("Router data store category name: \(router.dataStore?.categoryName ?? "nil")")
    }
    
    private func setupProductsCollectionView() {
        productsView.productsCollectionView.delegate = self
        productsView.productsCollectionView.dataSource = self
        productsView.productsCollectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.identifier
        )
    }
        
    private func requestProducts() {
        let request = Products.DisplayProducts.Request()
        interactor?.fetchProducts(request: request)
    }
    
    func addProductsToVariable(
        viewModel: Products.DisplayProducts.ViewModel
    ) {
        let products = viewModel.products
        self.products = products
        DispatchQueue.main.async {
            self.productsView.productsCollectionView.reloadData()
        }
    }
      
}

// MARK: - UITableViewDataSource

extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.identifier,
            for: indexPath
        ) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: products[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProductsViewController: UICollectionViewDelegate {

}

// MARK: - ProductsViewController + UICollectionViewDelegateFlowLayout

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
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

extension ProductsViewController {
    private func configureProductsViewConstraints() {
        NSLayoutConstraint.activate([
            productsView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            productsView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            productsView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            productsView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}
