//
//  MainViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/24.
//

import UIKit

class MainViewController: UIViewController {
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    var coordinate: MainFlow?
    
    private var mainCollectionView: UICollectionView! = nil
    private var dataSource: MainSectionDiffableDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpSearchController()
        configureCollectionView()
        configureDataSource()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        configureDataSource()
    }
    
    private func setUpSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "어디로 여행가세요?"
        searchController.obscuresBackgroundDuringPresentation = true // true이면 검색 중 뒷 배경 모두 흐릿하게 해줌
        searchController.searchResultsUpdater = self
        
        self.navigationItem.title = "Airbnb"
        self.navigationItem.searchController = searchController
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .white
        collectionView.register(
            HeroImageCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: HeroImageCollectionViewCell.self))
        collectionView.register(
            NearestDestinationCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: NearestDestinationCollectionViewCell.self))
        collectionView.register(
            MainAccomodationCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: MainAccomodationCollectionViewCell.self))
        collectionView.register(
            CommonHeaderView.self,
            forSupplementaryViewOfKind: MainViewController.sectionHeaderElementKind,
            withReuseIdentifier: String(describing: CommonHeaderView.self))
        mainCollectionView = collectionView
    }
    
    private func configureDataSource() {
        dataSource = MainSectionDiffableDataSource(collectionView: mainCollectionView,
                                                   cellProvider: { _, _, _ in
            return UICollectionViewCell()
        })
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<MainSection, MainImageItem> {
        var snapshot = NSDiffableDataSourceSnapshot<MainSection, MainImageItem>()
        snapshot.appendSections([MainSection.heroImage])
        snapshot.appendItems(Array(itemsForHeroImageSection().prefix(3)))
        
        snapshot.appendSections([MainSection.nearestDestination])
        snapshot.appendItems(itemsForNearestDestinationSection().suffix(3))
        
        snapshot.appendSections([MainSection.accomodation])
        snapshot.appendItems(itemsForAccomodationSection())
        return snapshot
    }
    
    private func itemsForHeroImageSection() -> [MainImageItem] {
        return MockDataModel.mockHeroImages // 섹션에 이 갯수만큼 아이템들이 나온다.
    }
    
    private func itemsForNearestDestinationSection() -> [MainImageItem] {
        return MockDataModel.mockHeroImages
    }
    
    private func itemsForAccomodationSection() -> [MainImageItem] {
        return [MainImageItem(title: "슬기로운 자연생활", imageName: "img_hero"),
                MainImageItem(title: "바다로 떠나요", imageName: "img_hero_beach")]
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout =
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = MainSection.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .heroImage:
                return self.generateHeroImageSection()
            case .nearestDestination:
                return self.generateNearestDestinationSection()
            case .accomodation:
                return self.generateAccomodationSection()
            }
        }
        return layout
    }
    
    private func generateHeroImageSection() -> NSCollectionLayoutSection {
        let item = configureItem()
        
        let group = configureGroup(MainSize(width: 1.0, heightComputedByWidth: 1.2),
                                   isDirectionVertical: false,
                                   item: item,
                                   itemCount: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func generateNearestDestinationSection() -> NSCollectionLayoutSection {
        let item = configureItem(contentInset: NSDirectionalEdgeInsets(top: 0,
                                                                       leading: 10,
                                                                       bottom: 0,
                                                                       trailing: 10))
        
        let group = configureGroup(MainSize(width: 3/4, heightComputedByWidth: 4/9),
                                   isDirectionVertical: true,
                                   item: item,
                                   itemCount: 2)
        
        let sectionHeader = configureHeader(MainSize(width: 1.0,
                                                     heightComputedByWidth: 0.2))
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func generateAccomodationSection() -> NSCollectionLayoutSection {
        let item = configureItem(contentInset: NSDirectionalEdgeInsets(top: 0,
                                                                       leading: 0,
                                                                       bottom: 0,
                                                                       trailing: -20))
        
        let group = configureGroup(MainSize(width: 3/4, heightComputedByWidth: 1.15),
                                   groupInset: NSDirectionalEdgeInsets(top: 0,
                                                                       leading: 20,
                                                                       bottom: 0,
                                                                       trailing: 20),
                                   isDirectionVertical: false,
                                   item: item,
                                   itemCount: 1)
        
        let sectionHeader = configureHeader(MainSize(width: 1.0,
                                                     heightComputedByWidth: 0.3))
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    struct ItemSize {
        let width: CGFloat
        let height: CGFloat
    }
    
    private func configureItem(_ itemSize: ItemSize = ItemSize(width: 1.0, height: 1.0),
                               contentInset: NSDirectionalEdgeInsets = .zero) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemSize.width),
            heightDimension: .fractionalHeight(itemSize.height))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = contentInset
        return item
    }
    
    struct MainSize {
        let width: CGFloat
        let heightComputedByWidth: CGFloat
    }
    
    private func configureGroup(_ groupSize: MainSize,
                                groupInset: NSDirectionalEdgeInsets = .zero,
                                isDirectionVertical: Bool,
                                item: NSCollectionLayoutItem,
                                itemCount: Int) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupSize.width),
            heightDimension: .fractionalWidth(groupSize.heightComputedByWidth))
        
        let group: NSCollectionLayoutGroup
        
        if isDirectionVertical {
            group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitem: item,
                count: itemCount)
        } else {
            group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: itemCount)
        }
        group.contentInsets = groupInset
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
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dump(searchController.searchBar.text)
    }
}
