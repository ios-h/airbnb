//
//  SearchFlowCoordinator.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/03.
//

import UIKit
    
protocol SearchFlow: AnyObject {
    func coordinateToCalendarViewController()
}

final class SearchFlowCoordinator: Coordinator, SearchFlow {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchRecommendationViewController = SearchRecommendationViewController()
        searchRecommendationViewController.coordinator = self
        
        navigationController?.pushViewController(searchRecommendationViewController, animated: false)
    }
    
    func coordinateToCalendarViewController() {
        guard let navigationController = navigationController else {
            return
        }
        
        let calendarFlowCoordinator = CalendarFlowCoordinator(navigationController: navigationController)
        coordinate(to: calendarFlowCoordinator)
    }
}
