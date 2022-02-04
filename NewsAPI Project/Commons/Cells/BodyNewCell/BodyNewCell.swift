//
//  BodyNewCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import UIKit

// MARK: - Constants

extension BodyNewCell {
    private enum Constants {
        static let numberOfLines = 0
        static let textAlignment = NSTextAlignment.justified
    }

    private enum Fonts {
        static let descriptionLabelFont = UIFont.regular(size: 15)
    }

    private enum Colours {
        static let descriptionLabelColor = UIColor.na_grey
    }
}

// MARK: - BodyNewCell

final class BodyNewCell: UITableViewCell, ReusableCell {
    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = Fonts.descriptionLabelFont
        descriptionLabel.textColor = Colours.descriptionLabelColor
        descriptionLabel.numberOfLines = Constants.numberOfLines
        descriptionLabel.textAlignment = Constants.textAlignment

        return descriptionLabel
    }()

    private func setupView() {
        contentView.addSubview(descriptionLabel)

        setupConstraints()
    }
}

// MARK: - Public methods

extension BodyNewCell {
    func configure(model: BodyNewCellModel) {
        descriptionLabel.text = model.description

        setupView()
        layoutIfNeeded()
    }
}

// MARK: - Constraints

extension BodyNewCell {
    private enum Constraints {
        static let titleTopContent = 10.0
        static let leadingWithContentView = 20.0
        static let trailingWithContentView = 20.0
        static let titleBottom = 10.0
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraints.titleTopContent),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.leadingWithContentView),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraints.titleBottom),

        ])
    }
}
