//
//  CategoriesTableViewCell.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 04.11.24.
//

import UIKit

final class CategoriesTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    enum Constants {
        static let identifier = "CategoriesTableViewCell"
        
        enum Insets {
            static let leading: CGFloat = 15
            static let trailing: CGFloat = -15
            static let verticalPadding: CGFloat = 10
        }
    }

    // MARK: - Visual Components
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews() {
        contentView.addSubviews([
            categoryLabel
        ])
    }
    
    private func setupConstraints() {
        configureLabelConstraints()
    }
    
    // MARK: - Public Methods
    
    func configureCell(categoryName: String) {
        self.categoryLabel.text = categoryName
    }
}

// MARK: - Constraints Configuration for CategoriesTableViewCell

extension CategoriesTableViewCell {
    private func configureLabelConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.Insets.verticalPadding
            ),
            categoryLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.Insets.leading
            ),
            categoryLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.Insets.trailing
            ),
            categoryLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.Insets.verticalPadding
            )
        ])
    }
}

