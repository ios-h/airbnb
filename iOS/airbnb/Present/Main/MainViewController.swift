//
//  MainViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/24.
//

import UIKit

class MainViewController: UIViewController, MainFlow {
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    enum Section: String, CaseIterable {
        case heroImage = "Hero Image"
        case nearestDestination = "가까운 여행지 둘러보기"
        case accomodation = "어디에서나, 여행은\n살아보는거야!"
    }
    
    var mainCollectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, HeroImageItem>! = nil
    
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
        searchController.obscuresBackgroundDuringPresentation = false // true이면 검색 중 뒷 배경 모두 흐릿하게 해줌
        
        self.navigationItem.title = "Airbnb"
        self.navigationItem.searchController = searchController
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.systemMint
        collectionView.delegate = self
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
        dataSource = UICollectionViewDiffableDataSource<Section, HeroImageItem>(
            collectionView: mainCollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, detailItem: HeroImageItem) -> UICollectionViewCell? in
                print("section \(indexPath.section) item \(indexPath.item)")
                let sectionType = Section.allCases[indexPath.section]
                switch sectionType {
                case .heroImage:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: String(describing: HeroImageCollectionViewCell.self),
                        for: indexPath) as? HeroImageCollectionViewCell else {
                        fatalError("Could not create new cell")
                    }
                    cell.titleLabel.text = detailItem.title
                    cell.heroImageView.image = UIImage(named: "\(detailItem.imageName)")
                    cell.isDataSourceConfigured = true
                    print(#function, cell.titleLabel.text)
                    return cell
                case .nearestDestination:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: String(describing: NearestDestinationCollectionViewCell.self),
                        for: indexPath) as? NearestDestinationCollectionViewCell else {
                        fatalError("Could not create new cell")
                    }
                    cell.titleLabel.text = detailItem.title
                    cell.detailLabel.text = "차로 30분 거리"
                    cell.cityImageView.image = UIImage(named: "img_hero_jeju")
                    cell.isDataSourceConfigured = true
                    print(#function, cell.titleLabel.text)
                    return cell
                case .accomodation:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: String(describing: MainAccomodationCollectionViewCell.self),
                        for: indexPath) as? MainAccomodationCollectionViewCell else {
                        fatalError("Could not create new cell")
                    }
                    cell.detailLabel.text = "자연생활을 만끼할 수\n있는 숙소"
                    cell.accomodationImageView.image = UIImage(named: "img_hero_beach")
                    cell.isDataSourceConfigured = true
                    print(#function, cell.detailLabel.text)
                    return cell
                }
            }
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let supplementaryView = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind,
                                                  withReuseIdentifier: String(describing: CommonHeaderView.self),
                                                  for: indexPath) as? CommonHeaderView else {
                fatalError("Cannot create header view")
            }
            
            supplementaryView.headerLabel.text = Section.allCases[indexPath.section].rawValue
            return supplementaryView
        }
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, HeroImageItem> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, HeroImageItem>()
        snapshot.appendSections([Section.heroImage])
        snapshot.appendItems(Array(itemsForHeroImageSection().prefix(3)))
        
        snapshot.appendSections([Section.nearestDestination])
        snapshot.appendItems(itemsForNearestDestinationSection().suffix(3))
        
        snapshot.appendSections([Section.accomodation])
        snapshot.appendItems(itemsForAccomodationSection())
        return snapshot
    }
    
    private func itemsForHeroImageSection() -> [HeroImageItem] {
        return MockDataModel.mockHeroImages // 섹션에 이 갯수만큼 아이템들이 나온다.
    }
    
    private func itemsForNearestDestinationSection() -> [HeroImageItem] {
        return MockDataModel.mockHeroImages
    }
    
    private func itemsForAccomodationSection() -> [HeroImageItem] {
        return [HeroImageItem(title: "슬기로운 자연생활", imageName: "img_hero"),
                HeroImageItem(title: "바다로 떠나요", imageName: "img_hero_beach")]
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout =
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = Section.allCases[sectionIndex]
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
            widthDimension: .fractionalWidth(3/4),
            heightDimension: .fractionalWidth(1.2))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(3/4),
            heightDimension: .fractionalWidth(1/2))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        
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
}

extension MainViewController: UICollectionViewDelegate {
    
}
