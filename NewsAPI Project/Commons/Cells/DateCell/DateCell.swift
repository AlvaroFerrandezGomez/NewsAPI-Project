//
//  DateCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import UIKit

// MARK: - Constants

extension DateCell {
    private enum Constants {
        static let numberOfLines = 0
        static let textAlignment = NSTextAlignment.center
        static let originalFormatDate = "yyyy-MM-dd'T'HH:mm:ssZ"
        static let finalFormatDate = "dd/MM/yyyy - HH:mm"
        static let hourUnit = "h"
    }

    private enum Fonts {
        static let dateLabelFont = UIFont.regular(size: 12)
    }

    private enum Colours {
        static let dateLabelColor = UIColor.na_magenta
    }
}

// MARK: - DateCell

final class DateCell: UITableViewCell, ReusableCell {
    var dateLabel: UILabel = {
        let dateLabel = UILabel(frame: .zero)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = Fonts.dateLabelFont
        dateLabel.textColor = Colours.dateLabelColor
        dateLabel.numberOfLines = Constants.numberOfLines
        dateLabel.textAlignment = Constants.textAlignment

        return dateLabel
    }()

    private func setupView() {
        contentView.addSubview(dateLabel)
        setupConstraints()
    }
}

// MARK: - Public methods

extension DateCell {
    func configure(model: DateCellModel) {
        dateLabel.text = getFormattedDate(from: model.date)

        setupView()
        layoutIfNeeded()
    }
}

// MARK: - Private methods

extension DateCell {
    private func getFormattedDate(from: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.originalFormatDate

        let date = dateFormatter.date(from: from) ?? Date()

        let dateFormatterFinal = DateFormatter()
        dateFormatterFinal.dateFormat = Constants.finalFormatDate

        return dateFormatterFinal.string(from: date) + Constants.hourUnit
    }
}

// MARK: - Constraints

extension DateCell {
    private enum Constraints {
        static let dateTopContent = 10.0
        static let leadingWithContentView = 20.0
        static let trailingWithContentView = 20.0
        static let dateBottomContent = 10.0
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraints.dateTopContent),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.leadingWithContentView),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraints.dateBottomContent),
        ])
    }
}
