//
//  SearchFlowCoordinator.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/03.
//

import UIKit
    
protocol SearchFlow: AnyObject {
    func coordinateToSearchPreview()
}

class SearchFlowCoordinator: Coordinator, SearchFlow {
    weak var navigationController: UINavigationController?
    var searchViewController: SearchViewController?
    var searchPreviewViewController: SearchPreviewViewController?
    
    init(navigationController: UINavigationController, searchViewController: SearchViewController) {
        self.navigationController = navigationController
        self.searchViewController = searchViewController
    }
    
    func start() {
        searchViewController?.coordinate = self
        
        searchPreviewViewController = SearchPreviewViewController()
        searchPreviewViewController?.coordinate = self
    }
    
    func coordinateToSearchPreview() {
        guard let searchPreviewViewController = searchPreviewViewController else {
            return
        }
        navigationController?.pushViewController(searchPreviewViewController, animated: true)
    }
}
