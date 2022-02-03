//
//  BodyNewCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import UIKit

final class BodyNewCell: UITableViewCell, ReusableCell {
    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.regular(size: 15)
        descriptionLabel.textColor = UIColor.na_grey
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .justified

        return descriptionLabel
    }()

    private func setupView() {
        contentView.addSubview(descriptionLabel)

        setupConstraints()
    }

    func configure(model: BodyNewCellModel) {
        descriptionLabel.text = model.description

        setupView()
        layoutIfNeeded()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

        ])
    }
}
