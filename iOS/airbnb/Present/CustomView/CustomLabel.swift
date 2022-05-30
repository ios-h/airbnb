//
//  CustomLabel.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/26.
//

import UIKit

class CustomLabel: UILabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(numberOfLines: Int, color: UIColor, attributedString: NSMutableAttributedString, font: UIFont) {
        self.init()

        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = numberOfLines
        self.textColor = color
        self.attributedText = attributedString
        self.font = font
    }
}
