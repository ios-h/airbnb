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
    weak var searchViewController: SearchViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController()
        navigationController?.pushViewController(mainViewController, animated: false)
    }
    
    func coordinateToSearchViewController() {
        let searchViewController = SearchViewController()
        self.searchViewController = searchViewController
        navigationController?.pushViewController(searchViewController, animated: false)
    }
}
