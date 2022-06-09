//
//  CalendarFlowCoordinator.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/08.
//

import UIKit

protocol CalendarFlow: AnyObject {
}

final class CalendarFlowCoordinator: Coordinator, CalendarFlow {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let calendarVieController = CalendarViewController()
        calendarVieController.coordinator = self
        
        navigationController?.pushViewController(calendarVieController, animated: false)
    }
}
