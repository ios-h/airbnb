//
//  CustomButton.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/26.
//

import UIKit

final class CustomButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(title: String,
                     state: UIControl.State,
                     buttonTheme: ButtonTheme?) {
        self.init()

        let color = buttonTheme?.customColor
        let font = buttonTheme?.font
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: state)
        self.setTitleColor(color?.titleColor, for: state)
        self.backgroundColor = color?.backgroundColor
        self.titleLabel?.font = font
        self.layer.cornerRadius = 10
    }
}
