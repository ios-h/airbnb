//
//  MainAccomodationCollectionViewCell.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/30.
//

import UIKit

class MainAccomodationCollectionViewCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let accomodationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .gray1
        return label
    }()
    
    var isDataSourceConfigured: Bool? {
        didSet {
            configure()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        contentView.backgroundColor = .gray6
        contentView.addSubview(containerView)
        
        containerView.addSubview(accomodationImageView)
        containerView.addSubview(detailLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        containerView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        accomodationImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        accomodationImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        accomodationImageView.heightAnchor.constraint(equalTo: accomodationImageView.widthAnchor,
                                                      multiplier: 1.2).isActive = true
        accomodationImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        detailLabel.leadingAnchor.constraint(equalTo: accomodationImageView.leadingAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: accomodationImageView.trailingAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: accomodationImageView.bottomAnchor, constant: 10).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10).isActive = true
    }
}
