//
//  WishListCollectionViewCell.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/07.
//

import UIKit

class WishListCollectionViewCell: CommonCollectionViewCell {
    
    func configure(with cell: WishListModel) {
        let imgUrl = cell.imageUrls?.randomElement() ?? ""
        
        if imgUrl.count > 0 {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: URL(string: imgUrl)!) {
                    let img = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        self.accomodationImageView.image = img
                    }
                }
            }
        }
        self.ratingLabel.text = "\(cell.rating ?? 0)"
        self.reviewCountingLabel.text = "(후기 \(cell.reviewCount ?? 0)개)"
        self.accomodationNameLabel.text = cell.accomodationName
        self.accomodationPriceLabel.text = "₩\(cell.price) / 박"
    }
    
    private let accomodationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let superHostButton = CustomButton(title: "슈퍼호스트",
                                               state: .normal,
                                               buttonTheme:
                                                ButtonTheme(customColor: CustomColor(titleColor: .black,
                                                                                     backgroundColor: .white),
                                                            font: .systemFont(ofSize: 15, weight: .regular)))
                                               
    private let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let horizontalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let starImageView: UIImageView = {
        let image = UIImage(named: "icon_star")?.withTintColor(.primary ?? UIColor.red)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let ratingLabel: CustomLabel = CustomLabel(color: .gray1,
                                                            text: "4.98",
                                                            font: .systemFont(ofSize: 12,
                                                                              weight: .regular))
    
    private let reviewCountingLabel: CustomLabel = CustomLabel(color: .gray3,
                                                                    text: "(후기 \(150)개)",
                                                                    font: .systemFont(ofSize: 12,
                                                                                      weight: .regular))
    
    private let accomodationNameLabel: CustomLabel = CustomLabel(color: .customBlack,
                                                         text: "비담집, 비우고담은집(집전체, 최대4인)",
                                                         font: .systemFont(ofSize: 20,
                                                                           weight: .regular))
    
    private let accomodationPriceLabel: CustomLabel = CustomLabel(color: .customBlack,
                                                         text: "₩308,571 / 박",
                                                         font: .systemFont(ofSize: 16,
                                                                           weight: .regular))
    
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
        
        containerView.addSubview(accomodationImageView)
        accomodationImageView.addSubview(superHostButton)
        accomodationImageView.addSubview(heartButton)
        
        containerView.addSubview(horizontalView)
        horizontalView.addSubview(starImageView)
        horizontalView.addSubview(ratingLabel)
        horizontalView.addSubview(reviewCountingLabel)
        
        containerView.addSubview(accomodationNameLabel)
        containerView.addSubview(accomodationPriceLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        containerView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        accomodationImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        accomodationImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        accomodationImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        
        superHostButton.leadingAnchor.constraint(equalTo: accomodationImageView.leadingAnchor,
                                                 constant: 20).isActive = true
        superHostButton.topAnchor.constraint(equalTo: accomodationImageView.topAnchor, constant: 20).isActive = true
        superHostButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        superHostButton.widthAnchor.constraint(equalTo: superHostButton.heightAnchor, multiplier: 3.5).isActive = true
        
        heartButton.trailingAnchor.constraint(equalTo: accomodationImageView.trailingAnchor,
                                                 constant: -20).isActive = true
        heartButton.topAnchor.constraint(equalTo: accomodationImageView.topAnchor, constant: 20).isActive = true
        heartButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        heartButton.widthAnchor.constraint(equalTo: heartButton.heightAnchor).isActive = true
        
        horizontalView.leadingAnchor.constraint(equalTo: accomodationImageView.leadingAnchor).isActive = true
        horizontalView.trailingAnchor.constraint(equalTo: accomodationImageView.trailingAnchor).isActive = true
        horizontalView.topAnchor.constraint(equalTo: accomodationImageView.bottomAnchor, constant: 10).isActive = true
        horizontalView.heightAnchor.constraint(equalToConstant: self.bounds.width * 0.05).isActive = true
        
        starImageView.leadingAnchor.constraint(equalTo: horizontalView.leadingAnchor).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: self.bounds.width * 0.05).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: self.bounds.width * 0.05).isActive = true
        starImageView.centerYAnchor.constraint(equalTo: horizontalView.centerYAnchor).isActive = true
        
        ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 3).isActive = true
        ratingLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor).isActive = true
        
        reviewCountingLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 3).isActive = true
        reviewCountingLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor).isActive = true
        
        horizontalView.heightAnchor.constraint(equalTo: starImageView.heightAnchor).isActive = true
        
        accomodationNameLabel.leadingAnchor.constraint(equalTo: accomodationImageView.leadingAnchor).isActive = true
        accomodationNameLabel.topAnchor.constraint(equalTo: horizontalView.bottomAnchor, constant: 5).isActive = true
        accomodationNameLabel.heightAnchor.constraint(equalToConstant: self.bounds.width * 0.07).isActive = true
        
        accomodationPriceLabel.leadingAnchor.constraint(equalTo: accomodationImageView.leadingAnchor).isActive = true
        accomodationPriceLabel.topAnchor.constraint(equalTo: accomodationNameLabel.bottomAnchor,
                                                    constant: 5).isActive = true
        accomodationPriceLabel.heightAnchor.constraint(equalToConstant: self.bounds.width * 0.07).isActive = true
        accomodationPriceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
}
