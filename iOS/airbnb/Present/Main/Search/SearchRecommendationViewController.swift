//
//  SearchRecommendationViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/31.
//

import UIKit

protocol SearchRecommendationDelegate: AnyObject {
    func searchBarTextDidChange(string: String)
}

final class SearchRecommendationViewController: UIViewController {

    var coordinator: SearchFlow?
    var delegate: SearchRecommendationDelegate?

    private var searchResultViewController = SearchResultViewController()
    private var searchCollectionView: UICollectionView! = nil
    private var dataSource: SearchDiffableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setUpSearchController()
        configureCollectionView()
        configureDataSource()
        
        DispatchQueue.main.async {
            self.navigationItem.searchController?.searchBar.searchTextField.becomeFirstResponder()
        }
        
        delegate = searchResultViewController
    }
    
    private func setUpSearchController() {
        let searchController = UISearchController(searchResultsController: searchResultViewController)
        searchController.searchBar.placeholder = "어디로 여행가세요?"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        
        self.navigationItem.title = "숙소 찾기"
        self.navigationItem.searchController = searchController
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
                return self.generateSearchRecommendationSection()
            }
        }
        return layout
    }
    
    private func generateSearchRecommendationSection() -> NSCollectionLayoutSection {
        
        let item = LayoutManager().configureItem(ItemSize(width: 1, height: 5),
                                                 contentInset: NSDirectionalEdgeInsets(top: 0,
                                                                                       leading: 10,
                                                                                       bottom: 0,
                                                                                       trailing: 10))
        
        let groupType = MainGroupType(groupSize: GroupSize(width: .fractionalWidth(1.0),
                                                           height: .fractionalHeight(1.0)),
                                      isDirectionVertical: true,
                                      item: item,
                                      itemCount: 10)
        
        let group = LayoutManager().configureGroup(groupType: groupType)
        
        let sectionHeader = LayoutManager().configureHeader(GroupSize(width: .fractionalWidth(1.0),
                                                                      height: .fractionalWidth(0.17)),
                                                            elementKind: MainViewController.sectionHeaderElementKind)
        
        let sectionType = MainSectionType(group: group,
                                          header: sectionHeader)
        
        let section = LayoutManager().configureSection(sectionType: sectionType)
        return section
    }
}

extension SearchRecommendationViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        delegate?.searchBarTextDidChange(string: text)
    }
}

extension SearchRecommendationViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        coordinator?.coordinateToSearchDetail()
        return true
    }
}
