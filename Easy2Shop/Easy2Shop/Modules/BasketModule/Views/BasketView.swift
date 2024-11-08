//
//  BasketView.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 08.11.24.
//

import UIKit

final class BasketView: UIView {
    
    // MARK: - Constants
    
    enum Constants {
        enum Insets {
            static let top: CGFloat = 15
            static let bottom: CGFloat = -20
            static let leading: CGFloat = 20
            static let trailing: CGFloat = -20
            static let inset: CGFloat = 10
            static let titleHeight: CGFloat = 40
            static let buttonHeight: CGFloat = 60
            static let tableViewHeightMultiplier: CGFloat = 0.8
        }
        
        enum Texts {
            static let title = "My Basket"
            static let payButton = "Pay $100"
        }
    }
    
    // MARK: - Visual Components
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.title
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
    
    let payButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.Texts.payButton, for: .normal)
        button.backgroundColor = .payButtonBackground
        button.layer.cornerRadius = 18
        return button
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
            titleLabel,
            productsCollectionView,
            payButton
        ])
        backgroundColor = .white
    }
    
    private func configureConstraints() {
        configureTitleLabelConstraints()
        configureCollectionViewConstraints()
        configurePayButtonConstraints()
    }
}

// MARK: - Constraints Configuration

extension BasketView {
    private func configureTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.Insets.top
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.Insets.leading
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Constants.Insets.trailing
            ),
            titleLabel.heightAnchor.constraint(
                equalToConstant: Constants.Insets.titleHeight
            )
        ])
    }
    
    private func configureCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Constants.Insets.top
            ),
            productsCollectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            productsCollectionView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            productsCollectionView.bottomAnchor.constraint(
                equalTo: payButton.topAnchor,
                constant: 10
            )
        ])
    }
    
    private func configurePayButtonConstraints() {
        NSLayoutConstraint.activate([
            payButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.Insets.inset
            ),
            payButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.Insets.inset
            ),
            payButton.heightAnchor.constraint(
                equalToConstant: Constants.Insets.titleHeight
            ),
            payButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: Constants.Insets.bottom
            )
        ])
    }
    
}

