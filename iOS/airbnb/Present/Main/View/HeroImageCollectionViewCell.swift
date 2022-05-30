//
//  HeroImageCollectionViewCell.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/30.
//

import UIKit

class HeroImageCollectionViewCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 34, weight: .medium)
        return label
    }()
    
    var isDataSourceConfigured: Bool? {
        didSet {
            configure()
        }
    }
    
    private let detailLabel = CustomLabel(numberOfLines: 0,
                                          color: .gray1!,
                                          attributedString:
                                            NSMutableAttributedString(string: "에어비앤비가 엄선한\n위시리스트를 만나보세요."),
                                          font: .systemFont(ofSize: 17, weight: .medium))
    
    private let ideaButton = CustomButton(title: "여행 아이디어 얻기",
                                          state: .normal,
                                          titleColor: .white!,
                                          backgroundColor: .black,
                                          font: .systemFont(ofSize: 17, weight: .bold))
    
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
        
        containerView.addSubview(heroImageView)
        heroImageView.addSubview(titleLabel)
        heroImageView.addSubview(detailLabel)
        heroImageView.addSubview(ideaButton)
        
        setConstraints()
    }
    
    private func setConstraints() {
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        heroImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        heroImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        heroImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        heroImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: heroImageView.topAnchor, constant: 20).isActive = true
        
        detailLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        ideaButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        ideaButton.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 20).isActive = true
        ideaButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.5).isActive = true
        ideaButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
