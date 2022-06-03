//
//  MainFlowCoordinator.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/27.
//

import UIKit

protocol MainFlow: AnyObject {
    func coordinateToSearchViewController(searchViewController: UISearchController)
}

class MainFlowCoordinator: Coordinator, MainFlow {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController()
        mainViewController.coordinate = self
        navigationController?.pushViewController(mainViewController, animated: false)
    }
    
    func coordinateToSearchViewController(searchViewController: UISearchController) {
        guard let navigationController = navigationController else {
            return
        }

        guard let searchViewController = searchViewController as? SearchViewController else {
            return
        }
        
        let searchFlowCoordinator = SearchFlowCoordinator(navigationController: navigationController,
                                                          searchViewController: searchViewController)
        coordinate(to: searchFlowCoordinator)
    }
}
