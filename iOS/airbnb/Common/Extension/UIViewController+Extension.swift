//
//  UIViewController+Extension.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/09.
//

import UIKit

extension UIViewController {
    func alert(title: String, message: String, okTitle: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: handler)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
