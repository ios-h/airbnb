//
//  CalendarCollectionViewCell.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/08.
//

import SnapKit
import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
    let textLabel: CustomLabel = CustomLabel(color: .gray3,
                                                     text: "일",
                                                     font: .systemFont(ofSize: 12,
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
        contentView.addSubview(textLabel)
        
//        addSubview(containerView)
        setConstraints()
    }
    
    private func setConstraints() {
        contentView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
//        containerView.snp.makeConstraints {
//            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
//        }
        
        textLabel.snp.makeConstraints {
            $0.center.equalTo(self.contentView)
        }
    }
}
