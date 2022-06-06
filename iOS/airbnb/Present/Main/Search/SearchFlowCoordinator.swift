//
//  SearchFlowCoordinator.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/03.
//

import UIKit
    
protocol SearchFlow: AnyObject {
    func coordinateToSearchDetail()
}

final class SearchFlowCoordinator: Coordinator, SearchFlow {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchPreviewViewController = SearchRecommendationViewController()
        searchPreviewViewController.coordinator = self
        
        navigationController?.pushViewController(searchPreviewViewController, animated: false)
    }
    
    func coordinateToSearchDetail() {
    }
}
