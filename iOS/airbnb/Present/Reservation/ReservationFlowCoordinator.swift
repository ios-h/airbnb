//
//  ReservationFlowCoordinator.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/07.
//

import UIKit

protocol ReservationFlow: AnyObject {
}

final class ReservationFlowCoordinator: Coordinator, ReservationFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let reservationViewController = ReservationViewController()
        reservationViewController.coordinate = self
        navigationController?.pushViewController(reservationViewController, animated: true)
    }
}
