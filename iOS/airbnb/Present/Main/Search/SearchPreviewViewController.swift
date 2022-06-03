//
//  SearchPreviewViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/31.
//

import UIKit

class SearchPreviewViewController: UIViewController {

    var coordinate: SearchFlow?
    
    private var searchCollectionView: UICollectionView! = nil
    private var dataSource: SearchDiffableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .white
        collectionView.register(
            NearestDestinationCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: NearestDestinationCollectionViewCell.self))
        collectionView.register(
            CommonHeaderView.self,
            forSupplementaryViewOfKind: MainViewController.sectionHeaderElementKind,
            withReuseIdentifier: String(describing: CommonHeaderView.self))
        searchCollectionView = collectionView
    }
    
    private func configureDataSource() {
        dataSource = SearchDiffableDataSource(collectionView: searchCollectionView,
                                              cellProvider: { collectionView, indexPath, itemIdentifier in
            let sectionType = SearchSection.allCases[indexPath.section]
            
            switch sectionType {
            case .nearestPopularDestination:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: NearestDestinationCollectionViewCell.self),
                    for: indexPath) as? NearestDestinationCollectionViewCell else {
                    return UICollectionViewCell() }
                cell.titleLabel.text = itemIdentifier.title
                cell.detailLabel.text = itemIdentifier.description
                cell.cityImageView.image = UIImage(named: "\(itemIdentifier.imageName)")
                cell.isDataSourceConfigured = true
                return cell
            }
        })
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<SearchSection, SearchItem> {
        var snapshot = NSDiffableDataSourceSnapshot<SearchSection, SearchItem>()
        snapshot.appendSections([SearchSection.nearestPopularDestination])
        snapshot.appendItems(itemsForSearchCollectionView())
        return snapshot
    }
    
    private func itemsForSearchCollectionView() -> [SearchItem] {
        return MockDataModel.mockSearchItems
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout =
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = SearchSection.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .nearestPopularDestination:
                return self.generateSearchPreviewSection()
            }
        }
        return layout
    }
    
    private func generateSearchPreviewSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(5))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 8)
        
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
