//
//  CustomLabel.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/26.
//

import UIKit

final class CustomLabel: UILabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(color: UIColor?, text: String = "", font: UIFont) {
        self.init()

        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
        self.textColor = color
        self.attributedText = NSMutableAttributedString(string: text)
        self.font = font
    }
}
