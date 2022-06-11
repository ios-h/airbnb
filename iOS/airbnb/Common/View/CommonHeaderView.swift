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
        
        headerLabel.snp.makeConstraints {
            $0.leading.equalTo(inset)
            $0.top.equalTo(self.snp.top).inset(inset * 1.1)
            $0.bottom.equalTo(self.snp.bottom).inset(inset * 0.4)
        }
    }
}
