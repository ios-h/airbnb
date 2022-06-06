//
//  MainSectionLayout.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/03.
//

import UIKit

struct MainGroupType: GroupApplicable {
    var groupSize: GroupSize
    var groupInset: NSDirectionalEdgeInsets = .zero
    var isDirectionVertical: Bool
    var item: NSCollectionLayoutItem
    var itemCount: Int
}

struct MainSectionType: SectionApplicable {
    var group: NSCollectionLayoutGroup
    var sectionInset: NSDirectionalEdgeInsets = .zero
    var scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .groupPaging
    var header: NSCollectionLayoutBoundarySupplementaryItem?
}

final class MainViewModel {
    
    func generateHeroImageSection() -> NSCollectionLayoutSection {
        let item = LayoutManager().configureItem()
        
        let groupType = MainGroupType(groupSize: GroupSize(width: .fractionalWidth(1.0),
                                                           height: .fractionalWidth(1.2)),
                                      isDirectionVertical: false,
                                      item: item,
                                      itemCount: 1)
        let group = LayoutManager().configureGroup(groupType: groupType)
        let sectionType = MainSectionType(group: group)
        let section = LayoutManager().configureSection(sectionType: sectionType)
        return section
    }
    
    func generateNearestDestinationSection() -> NSCollectionLayoutSection {
        let item = LayoutManager().configureItem(contentInset: NSDirectionalEdgeInsets(top: 0,
                                                                       leading: 10,
                                                                       bottom: 0,
                                                                       trailing: 10))
        
        let groupType = MainGroupType(groupSize: GroupSize(width: .fractionalWidth(3/4),
                                                           height: .fractionalWidth(4/9)),
                                      isDirectionVertical: true,
                                      item: item,
                                      itemCount: 2)
        let group = LayoutManager().configureGroup(groupType: groupType)
        
        let sectionHeader = LayoutManager().configureHeader(GroupSize(width: .fractionalWidth(1.0),
                                                                      height: .fractionalWidth(0.2)),
                                                            elementKind: MainViewController.sectionHeaderElementKind)
        
        let sectionType = MainSectionType(group: group, header: sectionHeader)
        let section = LayoutManager().configureSection(sectionType: sectionType)
        return section
    }
    
    func generateAccomodationSection() -> NSCollectionLayoutSection {
        let item = LayoutManager().configureItem(contentInset: NSDirectionalEdgeInsets(top: 0,
                                                                       leading: 0,
                                                                       bottom: 0,
                                                                       trailing: -20))
        
        let groupType = MainGroupType(groupSize: GroupSize(width: .fractionalWidth(3/4),
                                                           height: .fractionalWidth(1.15)),
                                      groupInset: NSDirectionalEdgeInsets(top: 0,
                                                                          leading: 20,
                                                                          bottom: 0,
                                                                          trailing: 20),
                                      isDirectionVertical: false,
                                      item: item,
                                      itemCount: 1)
        let group = LayoutManager().configureGroup(groupType: groupType)
        
        let sectionHeader = LayoutManager().configureHeader(GroupSize(width: .fractionalWidth(1.0),
                                                                      height: .fractionalWidth(0.3)),
                                                            elementKind: MainViewController.sectionHeaderElementKind)
        let sectionType = MainSectionType(group: group,
                                          sectionInset: NSDirectionalEdgeInsets(top: 0,
                                                                                leading: 0,
                                                                                bottom: 0,
                                                                                trailing: 20),
                                          header: sectionHeader)
        let section = LayoutManager().configureSection(sectionType: sectionType)
        return section
    }
}
