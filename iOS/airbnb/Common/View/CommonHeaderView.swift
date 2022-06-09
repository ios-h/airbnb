//
//  CommonHeaderView.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/30.
//

import UIKit

class CommonHeaderView: UICollectionReusableView {
    
    public let headerLabel = CustomLabel(color: .customBlack!, font: .systemFont(ofSize: 22, weight: .medium))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        backgroundColor = .white
        
        addSubview(headerLabel)
        
        let inset = CGFloat(25)
        
        headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset).isActive = true
        headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: inset * 1.2).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset * 0.5).isActive = true
    }
}
