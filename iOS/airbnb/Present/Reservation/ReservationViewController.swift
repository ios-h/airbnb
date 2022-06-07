//
//  ReservationViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/24.
//

import UIKit

final class ReservationViewController: UIViewController {

    var coordinate: ReservationFlow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configure()
    }
    
    private func configure() {
        self.navigationItem.title = "내 예약"
    }
}
