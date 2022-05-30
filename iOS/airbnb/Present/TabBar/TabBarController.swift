//
//  TabBarController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/27.
//

import UIKit

class TabBarController: UITabBarController {

    var coordintor: TabBarCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.backgroundColor = .gray6
        self.tabBar.tintColor = .customBlack
    }
}
