//
//  TitleCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import UIKit

// MARK: - Constants

extension TitleCell {
    private enum Constants {
        static let numberOfLines = 0
        static let textAlignment = NSTextAlignment.left
    }

    private enum Fonts {
        static let titleLabelFont = UIFont.extraBold(size: 22)
    }

    private enum Colours {
        static let titleLabelColor = UIColor.na_black
    }
}

// MARK: - TitleCell

final class TitleCell: UITableViewCell, ReusableCell {
    var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Fonts.titleLabelFont
        titleLabel.textColor = Colours.titleLabelColor
        titleLabel.numberOfLines = Constants.numberOfLines
        titleLabel.textAlignment = Constants.textAlignment

        return titleLabel
    }()

    private func setupView() {
        contentView.addSubview(titleLabel)
        setupConstraints()
    }
}

// MARK: - Public methods

extension TitleCell {
    func configure(model: TitleCellModel) {
        titleLabel.text = model.title

        setupView()
        layoutIfNeeded()
    }
}

// MARK: - Constraints

extension TitleCell {
    private enum Constraints {
        static let titleTopContent = 10.0
        static let leadingWithContentView = 20.0
        static let trailingWithContentView = 20.0
        static let titleBottom = 10.0
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraints.titleTopContent),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.leadingWithContentView),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraints.titleBottom),
        ])
    }
}
