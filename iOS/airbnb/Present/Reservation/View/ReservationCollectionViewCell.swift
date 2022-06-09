//
//  ReservationCollectionViewCell.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/08.
//

import UIKit

class ReservationCollectionViewCell: CommonCollectionViewCell {
    
    func configure(with cell: ReservationModel) {
        self.accomodationImageView.image = cell.image
        self.stayDurationLabel.text = "\(cell.duration)"
        self.locationLabel.text = "\(cell.location)"
        self.roomTypeLabel.text = "\(cell.roomType)"
    }
    
    private let accomodationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let stayDurationLabel: CustomLabel = CustomLabel(color: .gray3,
                                                            text: "2021년 5월 17일 - 2021년 6월 4일",
                                                            font: .systemFont(ofSize: 15,
                                                                              weight: .regular))
    
    private let locationLabel: CustomLabel = CustomLabel(color: .gray1,
                                                                    text: "서초구, 서울, 한국",
                                                                    font: .systemFont(ofSize: 20,
                                                                                      weight: .regular))
    
    private let roomTypeLabel: CustomLabel = CustomLabel(color: .gray1,
                                                         text: "Spacious and Comfortable cozy house #4",
                                                         font: .systemFont(ofSize: 17,
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
        containerView.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(stayDurationLabel)
        verticalStackView.addArrangedSubview(locationLabel)
        verticalStackView.addArrangedSubview(roomTypeLabel)
        
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
        
        verticalStackView.leadingAnchor.constraint(equalTo: accomodationImageView.leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: accomodationImageView.trailingAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: accomodationImageView.bottomAnchor,
                                               constant: 10).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
}
