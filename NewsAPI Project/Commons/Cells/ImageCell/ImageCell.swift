//
//  ImageCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import Kingfisher
import UIKit

// MARK: - Constants

extension ImageCell {
    private enum Constants {
        static let cornerRadius = CGFloat(6.0)
        static let contentMode = ContentMode.scaleAspectFill
    }
}

// MARK: - ImageCell

final class ImageCell: UITableViewCell, ReusableCell {
    var imageViewCell: UIImageView = {
        let imageViewCell = UIImageView(frame: .zero)
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        imageViewCell.contentMode = Constants.contentMode
        imageViewCell.clipsToBounds = true
        imageViewCell.layer.cornerRadius = Constants.cornerRadius

        return imageViewCell
    }()

    private func setupView() {
        contentView.addSubview(imageViewCell)
        setupConstraints()
    }
}

// MARK: - Public methods

extension ImageCell {
    func configure(model: ImageCellModel) {
        imageViewCell.kf.setImage(with: URL(string: model.imageURL))

        setupView()
        layoutIfNeeded()
    }
}

// MARK: - Constraints

extension ImageCell {
    private enum Constraints {
        static let leadingWithContentView = 20.0
        static let trailingWithContentView = 20.0
        static let totalHeight = 280.0
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.leadingWithContentView),
            imageViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            imageViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            contentView.heightAnchor.constraint(equalToConstant: Constraints.totalHeight)
        ])
    }
}
