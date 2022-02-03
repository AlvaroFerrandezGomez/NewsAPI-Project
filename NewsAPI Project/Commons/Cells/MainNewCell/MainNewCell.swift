//
//  MainNewCell.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import Kingfisher
import UIKit

final class MainNewCell: UITableViewCell, ReusableCell {
    var model: MainNewCellModel?
    
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
    
    var imageViewCell: UIImageView = {
        let imageViewCell = UIImageView(frame: .zero)
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        imageViewCell.layer.cornerRadius = 6.0
        imageViewCell.clipsToBounds = true
        imageViewCell.contentMode = .scaleAspectFill
        
        return imageViewCell
    }()

    var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.semibold(size: 16)
        titleLabel.textColor = UIColor.na_black
        titleLabel.numberOfLines = 2
        
        return titleLabel
    }()
    
    var dateLabel: UILabel = {
        let dateLabel = UILabel(frame: .zero)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.regular(size: 10)
        dateLabel.textAlignment = .left
        dateLabel.textColor = UIColor.na_magenta
        
        return dateLabel
    }()
    
    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.regular(size: 11)
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor.na_grey
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
    
    public func getId() -> String {
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
            borderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            borderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            borderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            borderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            imageViewCell.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 20),
            imageViewCell.heightAnchor.constraint(equalToConstant: 80),
            imageViewCell.widthAnchor.constraint(equalToConstant: 80),
            imageViewCell.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: imageViewCell.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -4),
            
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -4),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: borderView.bottomAnchor, constant: -20)
        ])
    }
}
