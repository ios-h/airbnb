//
//  TabBarCoordinator.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/27.
//

import UIKit

class TabBarCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordintor = self
        
        let mainNavigationController = UINavigationController()
        mainNavigationController.tabBarItem = UITabBarItem(title: "검색",
                                                           image: UIImage(named: "magnifyingglass"),
                                                           tag: 0)
        let mainCoordinator = MainFlowCoordinator(navigationController: mainNavigationController)
        
        let wishListViewController = WishListViewController()
        wishListViewController.tabBarItem = UITabBarItem(title: "위시리스트", image: UIImage(named: "heart"), tag: 1)
        wishListViewController.tabBarItem.selectedImage = UIImage(named: "heart.fill")
        
        let reservationViewController = ReservationViewController()
        reservationViewController.tabBarItem = UITabBarItem(title: "내 예약", image: UIImage(named: "person"), tag: 2)
        reservationViewController.tabBarItem.selectedImage = UIImage(named: "person.fill")
        
        tabBarController.viewControllers = [mainNavigationController,
                                            wishListViewController,
                                            reservationViewController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: false)
        
        coordinate(to: mainCoordinator)
    }
}
