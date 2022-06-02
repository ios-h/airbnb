//
//  MainSectionLayout.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/03.
//

import UIKit

struct ItemSize {
    var width: CGFloat = 1.0
    var height: CGFloat = 1.0
}

struct MainSize {
    var width: CGFloat = 1.0
    var heightComputedByWidth: CGFloat = 1.0
}

struct MainGroupType {
    var groupSize: MainSize
    var groupInset: NSDirectionalEdgeInsets = .zero
    var isDirectionVertical: Bool
    var item: NSCollectionLayoutItem
    var itemCount: Int
}

struct MainSectionType {
    var group: NSCollectionLayoutGroup
    var sectionInset: NSDirectionalEdgeInsets = .zero
    var scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .groupPaging
    var header: NSCollectionLayoutBoundarySupplementaryItem?
}

class MainSectionLayout {
    static func configureItem(_ itemSize: ItemSize = ItemSize(),
                              contentInset: NSDirectionalEdgeInsets = .zero) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemSize.width),
            heightDimension: .fractionalHeight(itemSize.height))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = contentInset
        return item
    }
    
    static func configureGroup(groupType: MainGroupType) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupType.groupSize.width),
            heightDimension: .fractionalWidth(groupType.groupSize.heightComputedByWidth))
        
        let group: NSCollectionLayoutGroup
        
        if groupType.isDirectionVertical {
            group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitem: groupType.item,
                count: groupType.itemCount)
        } else {
            group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: groupType.item,
                count: groupType.itemCount)
        }
        group.contentInsets = groupType.groupInset
        return group
    }

    static func configureHeader(_ size: MainSize) -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(size.width),
            heightDimension: .fractionalWidth(size.heightComputedByWidth))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MainViewController.sectionHeaderElementKind,
            alignment: .top)
        
        return sectionHeader
    }
    
    static func configureSection(sectionType: MainSectionType) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: sectionType.group)
        section.contentInsets = sectionType.sectionInset
        section.orthogonalScrollingBehavior = sectionType.scrollingBehavior
        
        if let header = sectionType.header {
            section.boundarySupplementaryItems = [header]
        }
        return section
    }
}
