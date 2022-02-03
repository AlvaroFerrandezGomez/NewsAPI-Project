//
//  TitleCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import UIKit

final class TitleCell: UITableViewCell, ReusableCell {
    var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.extraBold(size: 22)
        titleLabel.textColor = UIColor.na_black
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left

        return titleLabel
    }()

    private func setupView() {
        contentView.addSubview(titleLabel)

        setupConstraints()
    }

    func configure(model: TitleCellModel) {
        titleLabel.text = model.title

        setupView()
        layoutIfNeeded()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
