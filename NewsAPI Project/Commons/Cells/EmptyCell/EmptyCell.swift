//
//  EmptyCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

import Kingfisher
import UIKit

// MARK: - Constants

extension EmptyCell {
    private enum Constants {
        static let numberOfLines = 0
        static let cornerRadius = CGFloat(6.0)
        static let textAlignment = NSTextAlignment.center
        static let contentMode = ContentMode.scaleAspectFit
        static let emptyImage = "https://pbs.twimg.com/media/B5xf8PvCMAEA0rv?format=jpg&name=360x360"
    }

    private enum Fonts {
        static let titleLabelFont = UIFont.medium(size: 15)
    }

    private enum Colours {
        static let titleLabelColor = UIColor.na_black
    }
}

// MARK: - EmptyCell

final class EmptyCell: UITableViewCell, ReusableCell {
    var imageCell: UIImageView = {
        let imageViewCell = UIImageView(frame: .zero)
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        imageViewCell.contentMode = Constants.contentMode
        imageViewCell.clipsToBounds = true
        imageViewCell.layer.cornerRadius = Constants.cornerRadius

        return imageViewCell
    }()

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
        contentView.addSubview(imageCell)
        setupConstraints()
    }
}

// MARK: - Public methods

extension EmptyCell {
    func configure(model: EmptyCellModel) {
        titleLabel.text = model.title

        imageCell.kf.setImage(with: URL(string: Constants.emptyImage))

        setupView()
        layoutIfNeeded()
    }
}

// MARK: - Constraints

extension EmptyCell {
    private enum Constraints {
        static let heightWidthImage = 220.0
        static let imageTopContent = 10.0
        static let leadingWithContentView = 20.0
        static let trailingWithContentView = 20.0
        static let imageBottom = 10.0
        static let titleBottom = 10.0
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraints.imageTopContent),
            imageCell.heightAnchor.constraint(equalToConstant: Constraints.heightWidthImage),
            imageCell.widthAnchor.constraint(equalToConstant: Constraints.heightWidthImage),
            imageCell.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageCell.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -Constraints.imageBottom),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.leadingWithContentView),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraints.titleBottom),
        ])
    }
}
