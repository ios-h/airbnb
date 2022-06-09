//
//  ViewSize.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/06.
//

import UIKit

protocol ViewSize {
    var width: CGFloat { get }
    var height: CGFloat { get }
}

struct ItemSize: ViewSize {
    var width: CGFloat = 1.0
    var height: CGFloat = 1.0
}

struct GroupSize {
    var width: NSCollectionLayoutDimension
    var height: NSCollectionLayoutDimension
}

protocol GroupApplicable {
    var groupSize: GroupSize { get }
    var groupInset: NSDirectionalEdgeInsets { get }
    var isDirectionVertical: Bool { get }
    var item: NSCollectionLayoutItem { get }
    var itemCount: Int { get }
}

protocol SectionApplicable {
    var group: NSCollectionLayoutGroup { get }
    var sectionInset: NSDirectionalEdgeInsets { get }
    var scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior { get }
    var header: NSCollectionLayoutBoundarySupplementaryItem? { get }
}
