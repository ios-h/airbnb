//
//  CommonHeaderView.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/30.
//

import UIKit

class CommonHeaderView: UICollectionReusableView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textColor = .customBlack
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        backgroundColor = .gray6
        
        addSubview(headerLabel)
        
        let inset = CGFloat(25)
        
        headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset).isActive = true
        headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: inset).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset).isActive = true
    }
}
