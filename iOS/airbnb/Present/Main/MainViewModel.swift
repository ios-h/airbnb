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

class MainViewModel {
    
    static func generateHeroImageSection() -> NSCollectionLayoutSection {
        let item = MainViewModel().configureItem()
        
        let groupType = MainGroupType(groupSize: MainSize(width: 1.0, heightComputedByWidth: 1.2),
                                      isDirectionVertical: false,
                                      item: item,
                                      itemCount: 1)
        let group = MainViewModel().configureGroup(groupType: groupType)
        let sectionType = MainSectionType(group: group)
        let section = MainViewModel().configureSection(sectionType: sectionType)
        return section
    }
    
    static func generateNearestDestinationSection() -> NSCollectionLayoutSection {
        let item = MainViewModel().configureItem(contentInset: NSDirectionalEdgeInsets(top: 0,
                                                                       leading: 10,
                                                                       bottom: 0,
                                                                       trailing: 10))
        
        let groupType = MainGroupType(groupSize: MainSize(width: 3/4, heightComputedByWidth: 4/9),
                                      isDirectionVertical: true,
                                      item: item,
                                      itemCount: 2)
        let group = MainViewModel().configureGroup(groupType: groupType)
        
        let sectionHeader = MainViewModel().configureHeader(MainSize(width: 1.0,
                                                     heightComputedByWidth: 0.2))
        
        let sectionType = MainSectionType(group: group, header: sectionHeader)
        let section = MainViewModel().configureSection(sectionType: sectionType)
        return section
    }
    
    static func generateAccomodationSection() -> NSCollectionLayoutSection {
        let item = MainViewModel().configureItem(contentInset: NSDirectionalEdgeInsets(top: 0,
                                                                       leading: 0,
                                                                       bottom: 0,
                                                                       trailing: -20))
        
        let groupType = MainGroupType(groupSize: MainSize(width: 3/4, heightComputedByWidth: 1.15),
                                      groupInset: NSDirectionalEdgeInsets(top: 0,
                                                                          leading: 20,
                                                                          bottom: 0,
                                                                          trailing: 20),
                                      isDirectionVertical: false,
                                      item: item,
                                      itemCount: 1)
        let group = MainViewModel().configureGroup(groupType: groupType)
        
        let sectionHeader = MainViewModel().configureHeader(MainSize(width: 1.0,
                                                     heightComputedByWidth: 0.3))
        let sectionType = MainSectionType(group: group,
                                          sectionInset: NSDirectionalEdgeInsets(top: 0,
                                                                                leading: 0,
                                                                                bottom: 0,
                                                                                trailing: 20),
                                          header: sectionHeader)
        let section = MainViewModel().configureSection(sectionType: sectionType)
        return section
    }
    
    private func configureItem(_ itemSize: ItemSize = ItemSize(),
                               contentInset: NSDirectionalEdgeInsets = .zero) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemSize.width),
            heightDimension: .fractionalHeight(itemSize.height))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = contentInset
        return item
    }
    
    private func configureGroup(groupType: MainGroupType) -> NSCollectionLayoutGroup {
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
    
    private func configureHeader(_ size: MainSize) -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(size.width),
            heightDimension: .fractionalWidth(size.heightComputedByWidth))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MainViewController.sectionHeaderElementKind,
            alignment: .top)
        
        return sectionHeader
    }
    
    private func configureSection(sectionType: MainSectionType) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: sectionType.group)
        section.contentInsets = sectionType.sectionInset
        section.orthogonalScrollingBehavior = sectionType.scrollingBehavior
        
        if let header = sectionType.header {
            section.boundarySupplementaryItems = [header]
        }
        return section
    }
}
