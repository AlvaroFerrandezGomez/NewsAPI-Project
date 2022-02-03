//
//  DateCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import UIKit

final class DateCell: UITableViewCell, ReusableCell {
    var dateLabel: UILabel = {
        let dateLabel = UILabel(frame: .zero)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.regular(size: 12)
        dateLabel.textColor = UIColor.na_magenta
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .center

        return dateLabel
    }()

    private func setupView() {
        contentView.addSubview(dateLabel)

        setupConstraints()
    }

    func configure(model: DateCellModel) {
        dateLabel.text = getFormattedDate(from: model.date)

        setupView()
        layoutIfNeeded()
    }

    private func getFormattedDate(from: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let date = dateFormatter.date(from: from) ?? Date()

        let dateFormatterFinal = DateFormatter()
        dateFormatterFinal.dateFormat = "dd/MM/yyyy - HH:mm"

        return dateFormatterFinal.string(from: date) + "h"
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
