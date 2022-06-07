//
//  WishListFlowCoordinator.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/07.
//

import UIKit

protocol WishListFlow: AnyObject {
}

final class WishListFlowCoordinator: Coordinator, WishListFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let wishListViewController = WishListViewController()
        wishListViewController.coordinate = self
        navigationController?.pushViewController(wishListViewController, animated: true)
    }
}
