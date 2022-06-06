//
//  TabBarCoordinator.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/27.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordintor = self

        let controllerList = getControllers()
        
        var mainCoordinator: MainFlowCoordinator?
        if let mainNavigationController = controllerList.first as? UINavigationController {
            mainCoordinator = MainFlowCoordinator(navigationController: mainNavigationController)
        }
        
        tabBarController.viewControllers = controllerList
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: false)
        
        if let mainCoordinator = mainCoordinator {
            coordinate(to: mainCoordinator)
        }
    }
    
    private func getControllers() -> [UIViewController] {
        let mainNavigationController = UINavigationController()
        mainNavigationController.tabBarItem = UITabBarItem(title: "검색",
                                                           image: UIImage(named: "magnifyingglass"),
                                                           tag: 0)
        
        let wishListViewController = WishListViewController()
        wishListViewController.tabBarItem = UITabBarItem(title: "위시리스트", image: UIImage(named: "heart"), tag: 1)
        wishListViewController.tabBarItem.selectedImage = UIImage(named: "heart.fill")
        
        let reservationViewController = ReservationViewController()
        reservationViewController.tabBarItem = UITabBarItem(title: "내 예약", image: UIImage(named: "person"), tag: 2)
        reservationViewController.tabBarItem.selectedImage = UIImage(named: "person.fill")
        
        let controllerList = [mainNavigationController, wishListViewController, reservationViewController]
        return controllerList
    }
}
