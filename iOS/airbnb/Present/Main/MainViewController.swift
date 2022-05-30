//
//  MainViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/24.
//

import UIKit

class MainViewController: UIViewController, MainFlow {
//    static let sectionHeaderElementKind = "section-header-element-kind"
    
    enum Section: String, CaseIterable {
        case heroImage = "Hero Image"
        //        case nearestDestination = "Nearest Destination"
        //        case accomodation = "Accomodation"
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
        mainCollectionView = collectionView
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, HeroImageItem>(
            collectionView: mainCollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, detailItem: HeroImageItem) -> UICollectionViewCell? in
                print("section \(indexPath.section) item \(indexPath.item)")
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
            }
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, HeroImageItem> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, HeroImageItem>()
        snapshot.appendSections([Section.heroImage])
        let items = itemsForHeroImageSection()
        snapshot.appendItems(items)
        return snapshot
    }
    
    private func itemsForHeroImageSection() -> [HeroImageItem] {
        return MockDataModel.mockHeroImages // 섹션에 이 갯수만큼 아이템들이 나온다.
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout =
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .heroImage:
                return self.generateHeroImageSection()
//            case .nearestDestination:
//                return self.generateNearestDestinationSection()
//            case .accomodation:
//                return self.generateAccomodationSection()
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
        
//        let headerSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .estimated(1))
        
//        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerSize,
//            elementKind: MainViewController.sectionHeaderElementKind,
//            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
//        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}
