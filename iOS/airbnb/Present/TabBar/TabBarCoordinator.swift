//
//  TabBarCoordinator.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/27.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    private var mainCoordinator: MainFlowCoordinator?
    private var wishListCoordinator: WishListFlowCoordinator?
    private var reservationCoordinator: ReservationFlowCoordinator?
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self

        let controllerList = getControllers()
        
        if let mainNavigationController = controllerList.first as? UINavigationController {
            mainCoordinator = MainFlowCoordinator(navigationController: mainNavigationController)
        }
        
        if let wishListNavigationController = controllerList[1] as? UINavigationController {
            wishListCoordinator = WishListFlowCoordinator(navigationController: wishListNavigationController)
        }
        
        if let reservationNavigationController = controllerList.last as? UINavigationController {
            reservationCoordinator = ReservationFlowCoordinator(navigationController: reservationNavigationController)
        }
        
        tabBarController.viewControllers = controllerList
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: false)
        
        coordinate()
    }
    
    private func coordinate() {
        if let mainCoordinator = mainCoordinator {
            coordinate(to: mainCoordinator)
        }
        
        if let wishListCoordinator = wishListCoordinator {
            coordinate(to: wishListCoordinator)
        }
        
        if let reservationCoordinator = reservationCoordinator {
            coordinate(to: reservationCoordinator)
        }
    }
    
    private func getControllers() -> [UIViewController] {
        let mainNavigationController = UINavigationController()
        mainNavigationController.tabBarItem = UITabBarItem(title: "검색",
                                                           image: UIImage(named: "magnifyingglass"),
                                                           tag: 0)
        
        let wishListNavigationController = UINavigationController()
        wishListNavigationController.tabBarItem = UITabBarItem(title: "위시리스트",
                                                               image: UIImage(named: "heart"),
                                                               tag: 1)
        wishListNavigationController.tabBarItem.selectedImage = UIImage(named: "heart.fill")
        
        let reservationNavigationController = UINavigationController()
        reservationNavigationController.tabBarItem = UITabBarItem(title: "내 예약",
                                                                  image: UIImage(named: "person"),
                                                                  tag: 2)
        reservationNavigationController.tabBarItem.selectedImage = UIImage(named: "person.fill")
        
        let controllerList = [mainNavigationController, wishListNavigationController, reservationNavigationController]
        return controllerList
    }
}
