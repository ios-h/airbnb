//
//  MainCellFactory.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/05.
//

import UIKit

protocol MainCellFactory {
    func configureCell(mainViewCell: MainCollectionViewCell) -> MainCollectionViewCell
}
