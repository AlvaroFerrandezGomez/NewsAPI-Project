//
//  ShimmerCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 3/2/22.
//

import UIKit

// MARK: - Constants

extension ShimmerCell {
    private enum Constants {
        static let shadowOpacity = Float(0.2)
        static let shadowOffset = CGSize(width: 1, height: 4)
        static let shadowRadius = CGFloat(5.0)
        static let cornerRadius = 6.0
    }

    private enum Colours {
        static let shimmerColor = UIColor.na_shimmer_background
        static let shadowColor = UIColor.na_black.cgColor
        static let borderBackgroundColor = UIColor.white
    }
}

// MARK: - ShimmerCell

final class ShimmerCell: UITableViewCell, ReusableCell {
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

    var imageViewCellView: UIView = {
        let imageViewCellView = UIView(frame: .zero)
        imageViewCellView.translatesAutoresizingMaskIntoConstraints = false

        return imageViewCellView
    }()

    var titleLabelView: UIView = {
        let titleLabelView = UIView(frame: .zero)
        titleLabelView.translatesAutoresizingMaskIntoConstraints = false

        return titleLabelView
    }()

    var dateLabelView: UIView = {
        let dateLabelView = UIView(frame: .zero)
        dateLabelView.translatesAutoresizingMaskIntoConstraints = false

        return dateLabelView
    }()

    var descriptionLabelView: UIView = {
        let descriptionLabelView = UIView(frame: .zero)
        descriptionLabelView.translatesAutoresizingMaskIntoConstraints = false

        return descriptionLabelView
    }()

    private func setupView() {
        borderView.addSubview(imageViewCellView)
        borderView.addSubview(titleLabelView)
        borderView.addSubview(dateLabelView)
        borderView.addSubview(descriptionLabelView)
        contentView.addSubview(borderView)

        setupConstraints()
    }
}

// MARK: - Public methods

extension ShimmerCell {
    func configure() {
        setupView()
        setupShimers()
        layoutIfNeeded()
    }
}

// MARK: - Private methods

extension ShimmerCell {
    func setupShimers() {
        imageViewCellView.addShimmer(withCornerRadius: Constants.cornerRadius,
                                     withBackgroundColor: Colours.shimmerColor)
        titleLabelView.addShimmer(withCornerRadius: Constants.cornerRadius,
                                  withBackgroundColor: Colours.shimmerColor)
        dateLabelView.addShimmer(withCornerRadius: Constants.cornerRadius,
                                 withBackgroundColor: Colours.shimmerColor)
        descriptionLabelView.addShimmer(withCornerRadius: Constants.cornerRadius,
                                        withBackgroundColor: Colours.shimmerColor)
    }

    func shimmerShinnig() {
        DispatchQueue.main.async {
            self.imageViewCellView.startShining()
            self.titleLabelView.startShining()
            self.dateLabelView.startShining()
            self.descriptionLabelView.startShining()
        }
    }
}

// MARK: - Constraints

extension ShimmerCell {
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
        static let titleWidth = 207.0
        static let titleHeight = 24.0

        static let dateBottomDescription = 4.0
        static let dateHeight = 12.0

        static let descriptionWidth = 49.0
        static let descriptionBottomBorder = 20.0
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraints.borderTopContent),
            borderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.borderLeadingContent),
            borderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.borderTrailingContent),
            borderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraints.borderBottomContent),

            imageViewCellView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: Constraints.leadingImageBorder),
            imageViewCellView.heightAnchor.constraint(equalToConstant: Constraints.imageHeightWidth),
            imageViewCellView.widthAnchor.constraint(equalToConstant: Constraints.imageHeightWidth),
            imageViewCellView.topAnchor.constraint(equalTo: titleLabelView.topAnchor),

            titleLabelView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: Constraints.titleTopBorder),
            titleLabelView.widthAnchor.constraint(equalToConstant: Constraints.titleWidth),
            titleLabelView.heightAnchor.constraint(equalToConstant: Constraints.titleHeight),
            titleLabelView.leadingAnchor.constraint(equalTo: imageViewCellView.trailingAnchor, constant: Constraints.titleLeadingImage),
            titleLabelView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -Constraints.titleTrailingBorder),
            titleLabelView.bottomAnchor.constraint(equalTo: dateLabelView.topAnchor, constant: -Constraints.titleBottomDate),

            dateLabelView.leadingAnchor.constraint(equalTo: titleLabelView.leadingAnchor),
            dateLabelView.trailingAnchor.constraint(equalTo: titleLabelView.trailingAnchor),
            dateLabelView.bottomAnchor.constraint(equalTo: descriptionLabelView.topAnchor, constant: -Constraints.dateBottomDescription),
            dateLabelView.heightAnchor.constraint(equalToConstant: Constraints.dateHeight),

            descriptionLabelView.leadingAnchor.constraint(equalTo: titleLabelView.leadingAnchor),
            descriptionLabelView.trailingAnchor.constraint(equalTo: titleLabelView.trailingAnchor),
            descriptionLabelView.heightAnchor.constraint(equalToConstant: Constraints.descriptionWidth),
            descriptionLabelView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -Constraints.descriptionBottomBorder),
        ])
    }
}
