//
//  Size.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/09.
//

import UIKit

struct ItemSize: ViewSizeApplicable {
    var width: CGFloat = 1.0
    var height: CGFloat = 1.0
}

struct GroupSize {
    var width: NSCollectionLayoutDimension
    var height: NSCollectionLayoutDimension
}
