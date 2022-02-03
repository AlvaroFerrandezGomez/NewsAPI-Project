//
//  ImageCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import Kingfisher
import UIKit

final class ImageCell: UITableViewCell, ReusableCell {
    var imageViewCell: UIImageView = {
        let imageViewCell = UIImageView(frame: .zero)
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        imageViewCell.contentMode = .scaleAspectFill
        imageViewCell.clipsToBounds = true
        imageViewCell.layer.cornerRadius = 6.0

        return imageViewCell
    }()

    private func setupView() {
        contentView.addSubview(imageViewCell)

        setupConstraints()
    }

    func configure(model: ImageCellModel) {
        imageViewCell.kf.setImage(with: URL(string: model.imageURL))

        setupView()
        layoutIfNeeded()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageViewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

            contentView.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
}
