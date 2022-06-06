//
//  LayoutManager.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/06.
//

import UIKit

class LayoutManager {
    func configureGroup(groupType: GroupApplicable) -> NSCollectionLayoutGroup {
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(groupType.groupSize.width),
//            heightDimension: .fractionalWidth(groupType.groupSize.height))
        let groupSize = NSCollectionLayoutSize(widthDimension: groupType.groupSize.width,
                                               heightDimension: groupType.groupSize.height)
        
        let group: NSCollectionLayoutGroup
        
        if groupType.isDirectionVertical {
            group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitem: groupType.item,
                count: groupType.itemCount)
            group.contentInsets = groupType.groupInset
            return group
        }
        
        group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: groupType.item,
            count: groupType.itemCount)
        group.contentInsets = groupType.groupInset
        return group
    }
    
    func configureHeader(_ size: GroupSize, elementKind: String) -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: size.width,
            heightDimension: size.height)
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: elementKind,
            alignment: .top)
        
        return sectionHeader
    }
    
    func configureSection(sectionType: SectionApplicable) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: sectionType.group)
        section.contentInsets = sectionType.sectionInset
        section.orthogonalScrollingBehavior = sectionType.scrollingBehavior
        
        if let header = sectionType.header {
            section.boundarySupplementaryItems = [header]
        }
        return section
    }
    
    func configureItem(_ itemSize: ItemSize = ItemSize(),
                       contentInset: NSDirectionalEdgeInsets = .zero) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemSize.width),
            heightDimension: .fractionalHeight(itemSize.height))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = contentInset
        return item
    }
}
