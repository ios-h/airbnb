//
//  UIColor+Extension.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/25.
//

import UIKit

extension UIColor {
    static var customBlack: UIColor {
        guard let color = UIColor(named: "black") else { return UIColor.black }
        return color
    }
    
    static var blue: UIColor {
        guard let color = UIColor(named: "blue") else { return UIColor.systemBlue }
        return color
    }
    
    static var gray1: UIColor {
        guard let color = UIColor(named: "gray1") else { return UIColor.systemGray }
        return color
    }
    
    static var gray2: UIColor {
        guard let color = UIColor(named: "gray2") else { return UIColor.systemGray2 }
        return color
    }
    
    static var gray3: UIColor {
        guard let color = UIColor(named: "gray3") else { return UIColor.systemGray3 }
        return color
    }
    
    static var gray4: UIColor {
        guard let color = UIColor(named: "gray4") else { return UIColor.systemGray4 }
        return color
    }
    
    static var gray5: UIColor {
        guard let color = UIColor(named: "gray5") else { return UIColor.systemGray5 }
        return color
    }
    
    static var gray6: UIColor {
        guard let color = UIColor(named: "gray6") else { return UIColor.systemGray6 }
        return color
    }
    
    static var primary: UIColor {
        guard let color = UIColor(named: "primary") else { return UIColor.red }
        return color
    }
    
    static var secondary: UIColor {
        guard let color = UIColor(named: "secondary") else { return UIColor.green }
        return color
    }
    
    static var white: UIColor {
        guard let color = UIColor(named: "white") else { return UIColor.white }
        return color
    }
}
