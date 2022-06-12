//
//  CalendarHeaderView.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/12.
//

import UIKit

class CalendarHeaderView: UICollectionReusableView {
    
    func configureHeaderView(year: Int, month: Int) {
        self.headerLabel.text = "\(year)년 \(month)월"
    }
    
    private let headerLabel = CustomLabel(color: .customBlack!, font: .systemFont(ofSize: 16, weight: .bold))
    
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
            $0.top.equalTo(self.snp.top)
            $0.bottom.equalTo(self.snp.bottom).inset(inset * 0.4)
        }
    }
}
