//
//  SectionApplicable.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/09.
//

import UIKit

protocol SectionApplicable {
    var group: NSCollectionLayoutGroup { get }
    var sectionInset: NSDirectionalEdgeInsets { get }
    var scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior { get }
    var header: NSCollectionLayoutBoundarySupplementaryItem? { get }
}
