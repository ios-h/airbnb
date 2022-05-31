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
        
        view.backgroundColor = .gray6
        
        setUpSearchController()
        configureCollectionView()
        configureDataSource()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
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
        collectionView.backgroundColor = .gray6
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
                                                   cellProvider: { collectionView, indexPath, itemIdentifier in
            let sectionType = MainSection.allCases[indexPath.section]
            
            switch sectionType {
            case .heroImage:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: HeroImageCollectionViewCell.self),
                    for: indexPath) as? HeroImageCollectionViewCell else {
                    return UICollectionViewCell() }
                cell.titleLabel.text = itemIdentifier.title
                cell.heroImageView.image = UIImage(named: "\(itemIdentifier.imageName)")
                cell.isDataSourceConfigured = true
                return cell
            case .nearestDestination:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: NearestDestinationCollectionViewCell.self),
                    for: indexPath) as? NearestDestinationCollectionViewCell else {
                    return UICollectionViewCell() }
                cell.titleLabel.text = itemIdentifier.title
                cell.detailLabel.text = "차로 30분 거리"
                cell.cityImageView.image = UIImage(named: "img_hero_jeju")
                cell.isDataSourceConfigured = true
                return cell
            case .accomodation:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: MainAccomodationCollectionViewCell.self),
                    for: indexPath) as? MainAccomodationCollectionViewCell else {
                    return UICollectionViewCell() }
                cell.detailLabel.text = "자연생활을 만끼할 수\n있는 숙소"
                cell.accomodationImageView.image = UIImage(named: "img_hero_beach")
                cell.isDataSourceConfigured = true
                return cell
            }
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
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func generateNearestDestinationSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(8/9),
            heightDimension: .fractionalWidth(1/4))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(3/4),
            heightDimension: .fractionalWidth(4/9))
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 2)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(1))

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MainViewController.sectionHeaderElementKind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func generateAccomodationSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(4/7),
            heightDimension: .fractionalWidth(1.55))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -20)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(3/4),
            heightDimension: .fractionalWidth(1/2))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(1))

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MainViewController.sectionHeaderElementKind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dump(searchController.searchBar.text)
    }
}
