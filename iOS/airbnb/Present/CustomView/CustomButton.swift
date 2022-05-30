//
//  CustomButton.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/26.
//

import UIKit

class CustomButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(title: String,
                     state: UIControl.State,
                     titleColor: UIColor,
                     backgroundColor: UIColor,
                     font: UIFont) {
        self.init()

        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: state)
        self.setTitleColor(titleColor, for: state)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 10
    }
}
