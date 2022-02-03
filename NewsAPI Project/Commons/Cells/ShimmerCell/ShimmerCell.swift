//
//  ShimmerCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 3/2/22.
//

import UIKit

final class ShimmerCell: UITableViewCell, ReusableCell {
    var borderView: UIView = {
        let borderView = UIView(frame: .zero)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.masksToBounds = false
        borderView.layer.shadowColor = UIColor.na_black.cgColor
        borderView.layer.shadowOpacity = Float(0.2)
        borderView.layer.shadowOffset = CGSize(width: 1, height: 4)
        borderView.layer.shadowRadius = CGFloat(5.0)
        borderView.layer.cornerRadius = CGFloat(6.0)
        borderView.layer.shadowPath = nil
        borderView.backgroundColor = .white
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

    func configure() {
        setupView()
        setupShimers()
        layoutIfNeeded()
    }

    func setupShimers() {
        imageViewCellView.addShimmer(withCornerRadius: CGFloat(6.0), withBackgroundColor: UIColor.na_shimmer_background)
        titleLabelView.addShimmer(withCornerRadius: CGFloat(6.0), withBackgroundColor: UIColor.na_shimmer_background)
        dateLabelView.addShimmer(withCornerRadius: CGFloat(6.0), withBackgroundColor: UIColor.na_shimmer_background)
        descriptionLabelView.addShimmer(withCornerRadius: CGFloat(6.0), withBackgroundColor: UIColor.na_shimmer_background)
    }

    func shimmerShinnig() {
        DispatchQueue.main.async {
            self.imageViewCellView.startShining()
            self.titleLabelView.startShining()
            self.dateLabelView.startShining()
            self.descriptionLabelView.startShining()
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            borderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            borderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            borderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            imageViewCellView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 20),
            imageViewCellView.heightAnchor.constraint(equalToConstant: 80),
            imageViewCellView.widthAnchor.constraint(equalToConstant: 80),
            imageViewCellView.topAnchor.constraint(equalTo: titleLabelView.topAnchor),

            titleLabelView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 20),
            titleLabelView.widthAnchor.constraint(equalToConstant: 207),
            titleLabelView.heightAnchor.constraint(equalToConstant: 24),
            titleLabelView.leadingAnchor.constraint(equalTo: imageViewCellView.trailingAnchor, constant: 8),
            titleLabelView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -20),
            titleLabelView.bottomAnchor.constraint(equalTo: dateLabelView.topAnchor, constant: -4),

            dateLabelView.leadingAnchor.constraint(equalTo: titleLabelView.leadingAnchor),
            dateLabelView.trailingAnchor.constraint(equalTo: titleLabelView.trailingAnchor),
            dateLabelView.bottomAnchor.constraint(equalTo: descriptionLabelView.topAnchor, constant: -4),
            titleLabelView.widthAnchor.constraint(equalToConstant: 110),
            dateLabelView.heightAnchor.constraint(equalToConstant: 12),

            descriptionLabelView.leadingAnchor.constraint(equalTo: titleLabelView.leadingAnchor),
            descriptionLabelView.trailingAnchor.constraint(equalTo: titleLabelView.trailingAnchor),
            descriptionLabelView.heightAnchor.constraint(equalToConstant: 49),
            descriptionLabelView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -20),
        ])
    }
}
