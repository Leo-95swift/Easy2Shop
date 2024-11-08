//
//  ProductsView.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 05.11.24.
//

import UIKit

final class ProductsView: UIView {
    
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
    
    let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero, 
            collectionViewLayout: layout
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        return collectionView
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
            categoryNameLabel,
            productsCollectionView
        ])
        backgroundColor = .white
    }
    
    private func configureConstraints() {
        configureCategoryNameLabelConstraints()
        configureCollectionViewConstraints()
    }
}

// MARK: - Constraints Configuration

extension ProductsView {
    private func configureCategoryNameLabelConstraints() {
        NSLayoutConstraint.activate([
            categoryNameLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.Insets.top
            ),
            categoryNameLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.Insets.leading
            ),
            categoryNameLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Constants.Insets.trailing
            ),
            categoryNameLabel.heightAnchor.constraint(
                equalToConstant: Constants.Insets.titleHeight
            )
        ])
    }
    
    private func configureCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor.constraint(
                equalTo: categoryNameLabel.bottomAnchor,
                constant: Constants.Insets.top
            ),
            productsCollectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            productsCollectionView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            productsCollectionView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            )
        ])
    }
}
