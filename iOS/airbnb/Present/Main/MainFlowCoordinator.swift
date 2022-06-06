//
//  MainFlowCoordinator.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/27.
//

import UIKit

protocol MainFlow: AnyObject {
    func coordinateToSearchViewController()
}

class MainFlowCoordinator: Coordinator, MainFlow {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController()
        mainViewController.coordinate = self
        navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    func coordinateToSearchViewController() {
        guard let navigationController = navigationController else {
            return
        }
        
        let searchFlowCoordinator = SearchFlowCoordinator(navigationController: navigationController)
        coordinate(to: searchFlowCoordinator)
    }
}
