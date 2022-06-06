//
//  ViewSize.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/06.
//

import UIKit

protocol ViewSize {
    var width: CGFloat { get set }
    var height: CGFloat { get set }
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
    var groupSize: GroupSize { get set }
    var groupInset: NSDirectionalEdgeInsets { get set }
    var isDirectionVertical: Bool { get set }
    var item: NSCollectionLayoutItem { get set }
    var itemCount: Int { get set }
}

protocol SectionApplicable {
    var group: NSCollectionLayoutGroup { get set }
    var sectionInset: NSDirectionalEdgeInsets { get set }
    var scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior { get set }
    var header: NSCollectionLayoutBoundarySupplementaryItem? { get set }
}
