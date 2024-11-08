//
//  ProductsCollectionViewCell.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 05.11.24.
//

import UIKit

/// Переиспользуемая ячейка для показа продуктов
final class ProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants

    private enum Constants {
        enum Insets {
            static let imageCornerRadius: CGFloat = 40
            static let labelSize: CGFloat = 15
            static let imageHeight: CGFloat = 80
            static let cornerRadius: CGFloat = 40
            static let ratingLabelSize: CGFloat = 30
            static let buttonSize: CGFloat = 30
            static let spacing: CGFloat = 8
            static let leading: CGFloat = 15
            static let trailing: CGFloat = -15
        }
    }

    // MARK: - Visual Components

    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.Insets.imageCornerRadius
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()

    private lazy var productRatingLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = Constants.Insets.ratingLabelSize / 2
        label.layer.masksToBounds = true
        label.backgroundColor = .systemYellow
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()

    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()

    private lazy var addToBasketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
        return button
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Public Properties

    static let identifier = "ProductCollectionViewCell"

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        configureLayout()
        setupContentView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupSubviews() {
        contentView.addSubviews([
            productImageView,
            productRatingLabel,
            productTitleLabel,
            productPriceLabel,
            addToBasketButton,
            descriptionLabel
        ])
    }

    private func configureLayout() {
        configureProductImageViewConstraints()
        configureProductRatingLabelConstraints()
        configureProductTitleLabelConstraints()
        configureProductPriceLabelConstraints()
        configureAddToBasketButtonConstraints()
        configureDescriptionLabelConstraints()
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .systemPink
        contentView.layer.cornerRadius = Constants.Insets.cornerRadius
        contentView.layer.masksToBounds = true
    }
    
    // MARK: - Public Methods
    
    func configure(with info: Products.DisplayProducts.ViewModel.ProductInformationModel) {
        productImageView.image = info.productImage
        productRatingLabel.text = "\(info.productRating)"
        productTitleLabel.text = "\(info.productName)"
        productPriceLabel.text = "\(info.productPrice)"
        descriptionLabel.text = "\(info.productDescription)"
    }
    
}

// MARK: - Layout Configuration

extension ProductCollectionViewCell {
    private func configureProductImageViewConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.Insets.spacing
            ),
            productImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.Insets.leading
            ),
            productImageView.widthAnchor.constraint(
                equalToConstant: Constants.Insets.imageHeight
            ),
            productImageView.heightAnchor.constraint(
                equalToConstant: Constants.Insets.imageHeight
            )
        ])
    }

    private func configureProductRatingLabelConstraints() {
        NSLayoutConstraint.activate([
            productRatingLabel.centerYAnchor.constraint(
                equalTo: productImageView.bottomAnchor
            ),
            productRatingLabel.trailingAnchor.constraint(
                equalTo: productImageView.trailingAnchor,
                constant: -Constants.Insets.spacing
            ),
            productRatingLabel.widthAnchor.constraint(
                equalToConstant: Constants.Insets.ratingLabelSize
            ),
            productRatingLabel.heightAnchor.constraint(
                equalToConstant: Constants.Insets.ratingLabelSize
            )
        ])
    }

    private func configureProductTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            productTitleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.Insets.spacing
            ),
            productTitleLabel.leadingAnchor.constraint(
                equalTo: productImageView.trailingAnchor,
                constant: Constants.Insets.spacing
            ),
            productTitleLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: addToBasketButton.leadingAnchor,
                constant: -Constants.Insets.spacing
            )
        ])
    }

    private func configureProductPriceLabelConstraints() {
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(
                equalTo: productTitleLabel.bottomAnchor,
                constant: Constants.Insets.spacing / 2
            ),
            productPriceLabel.leadingAnchor.constraint(
                equalTo: productImageView.trailingAnchor,
                constant: Constants.Insets.spacing
            ),
            productPriceLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: addToBasketButton.leadingAnchor,
                constant: -Constants.Insets.spacing
            )
        ])
    }

    private func configureAddToBasketButtonConstraints() {
        NSLayoutConstraint.activate([
            addToBasketButton.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.Insets.spacing
            ),
            addToBasketButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.Insets.trailing
            ),
            addToBasketButton.widthAnchor.constraint(
                equalToConstant: Constants.Insets.buttonSize
            ),
            addToBasketButton.heightAnchor.constraint(
                equalToConstant: Constants.Insets.buttonSize
            )
        ])
    }

    private func configureDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(
                equalTo: productPriceLabel.bottomAnchor,
                constant: Constants.Insets.spacing
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: productImageView.trailingAnchor,
                constant: Constants.Insets.spacing
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.Insets.trailing
            ),
            descriptionLabel.heightAnchor.constraint(
                equalTo: heightAnchor,
                multiplier: 0.4
            ),
            descriptionLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.Insets.spacing
            )
        ])
    }
}

