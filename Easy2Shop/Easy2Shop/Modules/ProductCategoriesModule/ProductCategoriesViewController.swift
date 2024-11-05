//
//  ProductCategoriesViewController.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 03.11.24.
//

import UIKit

protocol ProductCategoriesDisplayLogic: AnyObject {
    func addCategoriesToVariable(viewModel: ProductCategories.DisplayProductCategories.ViewModel)
}

final class ProductCategoriesViewController: UIViewController, ProductCategoriesDisplayLogic {
    
    // MARK: VIP variables
    
     var interactor: ProductCategoriesBusinessLogic?
     var router: (NSObjectProtocol & ProductCategoriesRoutingLogic & ProductCategoriesDataPassing)?
    
    // MARK: - Visual Components
    
    private let productCategoriesView = ProductCategoriesView()
    
    // MARK: - Private Properties
    
    private var categories: [String] = []
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        configureSubviews()
        setupComponents()
        setupCategoriesTableView()
        requestProductCategories()
    }

    // MARK: - Private Methods
    
    private func setupSubviews() {
        view.addSubviews([
            productCategoriesView
        ])
        view.backgroundColor = .white
    }
    
    private func configureSubviews() {
        configureProductCategoriesViewConstraints()
    }
        
    private func setupComponents() {
        
        let viewController = self
        let interactor = ProductCategoriesInteractor()
        let presenter = ProductCategoriesPresenter()
        let router = ProductCategoriesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupCategoriesTableView() {
        productCategoriesView.categoriesTableView.delegate = self
        productCategoriesView.categoriesTableView.dataSource = self
        productCategoriesView.categoriesTableView.register(
            CategoriesTableViewCell.self,
            forCellReuseIdentifier: "CategoriesTableViewCell"
        )
    }
        
    private func requestProductCategories() {
        let request = ProductCategories.DisplayProductCategories.Request()
        interactor?.fetchProductCategories(request: request)
    }
    
    func addCategoriesToVariable(
        viewModel: ProductCategories.DisplayProductCategories.ViewModel
    ) {        
        let categories = viewModel.categories
        self.categories = categories
        DispatchQueue.main.async {
            self.productCategoriesView.categoriesTableView.reloadData()
        }
    }
      
}

// MARK: - UITableViewDataSource

extension ProductCategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoriesTableViewCell.Constants.identifier,
            for: indexPath
        ) as? CategoriesTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.configureCell(categoryName: categories[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProductCategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // interactor?.saveSelectedItem(character: characters[indexPath.row])
        // router?.routeToDetailedViewController()
    }
}

/// Расширение для установки размеров и расположений визуальных компонентов

extension ProductCategoriesViewController {
    private func configureProductCategoriesViewConstraints() {
        NSLayoutConstraint.activate([
            productCategoriesView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            productCategoriesView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            productCategoriesView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            productCategoriesView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}
