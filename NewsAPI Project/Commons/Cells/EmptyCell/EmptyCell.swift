//
//  EmptyCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 2/2/22.
//

import Kingfisher
import UIKit

final class EmptyCell: UITableViewCell, ReusableCell {
    var imageCell: UIImageView = {
        let imageViewCell = UIImageView(frame: .zero)
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        imageViewCell.contentMode = .scaleAspectFit

        return imageViewCell
    }()

    var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.medium(size: 15)
        titleLabel.textColor = UIColor.na_black
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center

        return titleLabel
    }()

    private func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageCell)

        setupConstraints()
    }

    func configure(model: EmptyCellModel) {
        titleLabel.text = model.title

        imageCell.kf.setImage(with: URL(string: "https://pbs.twimg.com/media/B5xf8PvCMAEA0rv?format=jpg&name=360x360"))

        setupView()
        layoutIfNeeded()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageCell.heightAnchor.constraint(equalToConstant: 220),
            imageCell.widthAnchor.constraint(equalToConstant: 220),
            imageCell.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageCell.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
