//
//  WishListViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/24.
//

import UIKit

final class WishListViewController: UIViewController {

    var coordinate: WishListFlow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configure()
    }
    
    private func configure() {
        self.navigationItem.title = "위시리스트"
    }
}
