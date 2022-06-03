//
//  MainViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/24.
//

import UIKit

class MainViewController: UIViewController {
    
    let mainViewModel = MainViewModel()
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
        let searchController = SearchViewController(searchResultsController: nil)
        self.navigationItem.title = "Airbnb"
        self.navigationItem.searchController = searchController
        
        print("SearchController를 MainFlowCoordinator로 전달.", searchController)
        coordinate?.coordinateToSearchViewController(searchViewController: searchController)
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
            let section = self.generateSection(sectionLayoutKind: sectionLayoutKind)
            return section
        }
        return layout
    }
    
    private func generateSection(sectionLayoutKind: MainSection) -> NSCollectionLayoutSection {
        switch sectionLayoutKind {
        case .heroImage:
            return mainViewModel.generateHeroImageSection()
        case .nearestDestination:
            return mainViewModel.generateNearestDestinationSection()
        case .accomodation:
            return mainViewModel.generateAccomodationSection()
        }
    }
}
