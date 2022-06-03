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
        print("searchController를 SearchFlowCoordinator에서 전달 받음.", searchViewController)
        print("coordinate setting 완료", searchViewController?.coordinate)
        
        searchPreviewViewController = SearchPreviewViewController()
        searchPreviewViewController?.coordinate = self
        print("searchPreviewViewController set", searchPreviewViewController?.coordinate)
    }
    
    func coordinateToSearchPreview() {
//        let searchPreviewViewController = SearchPreviewViewController()
//        searchPreviewViewController.coordinate = self
        print("aaaa", searchPreviewViewController?.coordinate)
        
        guard let searchPreviewViewController = searchPreviewViewController else {
            return
        }


        navigationController?.pushViewController(searchPreviewViewController, animated: true)
    }
}
