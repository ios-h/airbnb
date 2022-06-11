//
//  CalendarHeaderView.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/12.
//

import UIKit

class CalendarHeaderView: UICollectionReusableView {
    
    func configureHeaderView(year: Int, month: Int) {
        self.yearLabel.text = "\(year)년"
        self.monthLabel.text = "\(month)월"
    }
    
    private let yearLabel = CustomLabel(color: .customBlack!, font: .systemFont(ofSize: 16, weight: .medium))
    
    private let monthLabel = CustomLabel(color: .customBlack!, font: .systemFont(ofSize: 16, weight: .medium))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        backgroundColor = .white
        
        addSubview(yearLabel)
        addSubview(monthLabel)
        
        let inset = CGFloat(25)
        
        yearLabel.snp.makeConstraints {
            $0.leading.equalTo(inset)
            $0.top.equalTo(self.snp.top).inset(inset * 1.1)
            $0.bottom.equalTo(self.snp.bottom).inset(inset * 0.4)
        }
        
        monthLabel.snp.makeConstraints {
            $0.leading.equalTo(yearLabel.snp.trailing).inset(inset * 0.4)
        }
    }
}
