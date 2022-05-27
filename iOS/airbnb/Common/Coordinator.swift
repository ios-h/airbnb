//
//  Coordinator.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/27.
//

import Foundation

protocol Coordinator {
    func start()
    func coordinate(to coordinate: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
