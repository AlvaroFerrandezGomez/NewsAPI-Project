//
//  MainNewCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import Kingfisher
import UIKit

// MARK: - Constants

extension MainNewCell {
    private enum Constants {
        static let numberOfLinesTitle = 2
        static let numberOfLinesDescription = 3
        static let textAlignmentDate = NSTextAlignment.left
        static let textAlignmentDescription = NSTextAlignment.left
        static let contentModeImage = ContentMode.scaleAspectFill
        static let originalFormatDate = "yyyy-MM-dd'T'HH:mm:ssZ"
        static let finalFormatDate = "dd/MM/yyyy - HH:mm"
        static let hourUnit = "h"
        static let cornerRadius = 6.0
        static let shadowOpacity = Float(0.2)
        static let shadowOffset = CGSize(width: 1, height: 4)
        static let shadowRadius = CGFloat(5.0)
    }

    private enum Fonts {
        static let titleLabelFont = UIFont.semibold(size: 16)
        static let dateLabelFont = UIFont.regular(size: 10)
        static let descriptionLabelFont = UIFont.regular(size: 11)
    }

    private enum Colours {
        static let titleLabelColor = UIColor.na_black
        static let dateLabelColor = UIColor.na_magenta
        static let descriptionLabelColor = UIColor.na_grey
        static let shadowColor = UIColor.na_black.cgColor
        static let borderBackgroundColor = UIColor.white
    }
}

// MARK: - MainNewCell

final class MainNewCell: UITableViewCell, ReusableCell {
    var model: MainNewCellModel?

    var borderView: UIView = {
        let borderView = UIView(frame: .zero)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.masksToBounds = false
        borderView.layer.shadowColor = Colours.shadowColor
        borderView.layer.shadowOpacity = Constants.shadowOpacity
        borderView.layer.shadowOffset = Constants.shadowOffset
        borderView.layer.shadowRadius = Constants.shadowRadius
        borderView.layer.cornerRadius = Constants.cornerRadius
        borderView.layer.shadowPath = nil
        borderView.backgroundColor = Colours.borderBackgroundColor
        borderView.clipsToBounds = false

        return borderView
    }()

    var imageViewCell: UIImageView = {
        let imageViewCell = UIImageView(frame: .zero)
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        imageViewCell.layer.cornerRadius = Constants.cornerRadius
        imageViewCell.clipsToBounds = true
        imageViewCell.contentMode = Constants.contentModeImage

        return imageViewCell
    }()

    var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Fonts.titleLabelFont
        titleLabel.textColor = Colours.titleLabelColor
        titleLabel.numberOfLines = Constants.numberOfLinesTitle

        return titleLabel
    }()

    var dateLabel: UILabel = {
        let dateLabel = UILabel(frame: .zero)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = Fonts.dateLabelFont
        dateLabel.textAlignment = Constants.textAlignmentDate
        dateLabel.textColor = Colours.dateLabelColor

        return dateLabel
    }()

    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = Fonts.descriptionLabelFont
        descriptionLabel.numberOfLines = Constants.numberOfLinesDescription
        descriptionLabel.textAlignment = Constants.textAlignmentDescription
        descriptionLabel.textColor = Colours.descriptionLabelColor

        return descriptionLabel
    }()

    private func setupView() {
        borderView.addSubview(imageViewCell)
        borderView.addSubview(titleLabel)
        borderView.addSubview(dateLabel)
        borderView.addSubview(descriptionLabel)
        contentView.addSubview(borderView)

        setupConstraints()
    }
}

// MARK: - Public methods

extension MainNewCell {
    func getId() -> String {
        return model?.id ?? ""
    }

    func configure(model: MainNewCellModel) {
        self.model = model

        imageViewCell.kf.setImage(with: URL(string: model.imageURL))

        titleLabel.text = model.title
        descriptionLabel.text = model.description
        dateLabel.text = getFormattedDate(from: model.date)

        setupView()
        layoutIfNeeded()
    }
}

// MARK: - Private methods

extension MainNewCell {
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

extension MainNewCell {
    private enum Constraints {
        static let borderTopContent = 10.0
        static let borderLeadingContent = 20.0
        static let borderTrailingContent = 20.0
        static let borderBottomContent = 10.0

        static let imageHeightWidth = 80.0
        static let leadingImageBorder = 20.0

        static let titleTopBorder = 20.0
        static let titleLeadingImage = 8.0
        static let titleTrailingBorder = 20.0
        static let titleBottomDate = 4.0

        static let dateBottomDescription = 4.0

        static let descriptionBottomBorder = 20.0
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraints.borderTopContent),
            borderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.borderLeadingContent),
            borderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.borderTrailingContent),
            borderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraints.borderBottomContent),

            imageViewCell.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: Constraints.leadingImageBorder),
            imageViewCell.heightAnchor.constraint(equalToConstant: Constraints.imageHeightWidth),
            imageViewCell.widthAnchor.constraint(equalToConstant: Constraints.imageHeightWidth),
            imageViewCell.topAnchor.constraint(equalTo: titleLabel.topAnchor),

            titleLabel.topAnchor.constraint(equalTo: borderView.topAnchor, constant: Constraints.titleTopBorder),
            titleLabel.leadingAnchor.constraint(equalTo: imageViewCell.trailingAnchor, constant: Constraints.titleLeadingImage),
            titleLabel.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -Constraints.titleTrailingBorder),
            titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -Constraints.titleBottomDate),

            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -Constraints.dateBottomDescription),

            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: borderView.bottomAnchor, constant: -Constraints.descriptionBottomBorder)
        ])
    }
}
