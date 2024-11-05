//
//  ProductCategoriesView.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 04.11.24.
//

import UIKit

final class ProductCategoriesView: UIView {
    
    // MARK: - Constants
    
    enum Constants {
        enum Insets {
            static let top: CGFloat = 15
            static let leading: CGFloat = 20
            static let trailing: CGFloat = -20
            static let titleHeight: CGFloat = 40
            static let tableViewHeightMultiplier: CGFloat = 0.8
        }
        enum Texts {
            static let categoriesTitle = "Categories"
        }
    }
    
    // MARK: - Visual Components
    
    let categoriesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.categoriesTitle
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.Constants.identifier)
        return tableView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        configureConstraints()
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews() {
        addSubviews([
            categoriesTitleLabel,
            categoriesTableView
        ])
        backgroundColor = .white
    }
    
    private func configureConstraints() {
        configureTitleLabelConstraints()
        configureTableViewConstraints()
    }
}

// MARK: - Constraints Configuration

extension ProductCategoriesView {
    private func configureTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            categoriesTitleLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.Insets.top
            ),
            categoriesTitleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.Insets.leading
            ),
            categoriesTitleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Constants.Insets.trailing
            ),
            categoriesTitleLabel.heightAnchor.constraint(
                equalToConstant: Constants.Insets.titleHeight
            )
        ])
    }
    
    private func configureTableViewConstraints() {
        NSLayoutConstraint.activate([
            categoriesTableView.topAnchor.constraint(
                equalTo: categoriesTitleLabel.bottomAnchor,
                constant: Constants.Insets.top
            ),
            categoriesTableView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            categoriesTableView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            categoriesTableView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            )
        ])
    }
}
