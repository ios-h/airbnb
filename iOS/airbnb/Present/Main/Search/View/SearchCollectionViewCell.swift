//
//  SearchCollectionViewCell.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/31.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.clipsToBounds = false
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let cityNameLabel = CustomLabel(color: .customBlack, font: .systemFont(ofSize: 17, weight: .medium))
    
    let descriptionLabel = CustomLabel(color: .gray3, font: .systemFont(ofSize: 17, weight: .medium))
    
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
        contentView.backgroundColor = .white
        contentView.addSubview(containerView)
        
        containerView.addSubview(cityImageView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(cityNameLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        containerView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        cityImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        cityImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        cityImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 6).isActive = true
        cityImageView.widthAnchor.constraint(equalTo: cityImageView.heightAnchor).isActive = true

        stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: 20).isActive = true
        stackView.heightAnchor.constraint(equalTo: cityImageView.heightAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
    }
}
