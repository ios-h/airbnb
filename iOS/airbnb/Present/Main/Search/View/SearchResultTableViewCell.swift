//
//  SearchResultTableViewCell.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/07.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(named: "img_search_city")
        return imageView
    }()
    
    let cityNameLabel = CustomLabel(color: .customBlack, font: .systemFont(ofSize: 17, weight: .medium))
    
    var isDataSourceConfigured: Bool? {
        didSet {
            configure()
        }
    }
    
    private func configure() {
        contentView.backgroundColor = .white
        contentView.addSubview(containerView)
        
        containerView.addSubview(cityImageView)
        containerView.addSubview(cityNameLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        containerView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        cityImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        cityImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        cityImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 6).isActive = true
        cityImageView.widthAnchor.constraint(equalTo: cityImageView.heightAnchor).isActive = true
        cityImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        cityImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true

        cityNameLabel.leadingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: 20).isActive = true
        cityNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        cityNameLabel.centerYAnchor.constraint(equalTo: cityImageView.centerYAnchor).isActive = true
    }
}
