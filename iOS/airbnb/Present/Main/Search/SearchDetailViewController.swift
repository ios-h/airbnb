//
//  SearchPreviewViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/31.
//

import UIKit

class SearchDetailViewController: UIViewController {

    var coordinator: SearchFlow?
    
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
    }
    
    private func setUpSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
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
                return self.generateSearchPreviewSection()
            }
        }
        return layout
    }
    
    private func generateSearchPreviewSection() -> NSCollectionLayoutSection {
        
        let item = LayoutManager().configureItem(ItemSize(width: 1, height: 5),
                                                 contentInset: NSDirectionalEdgeInsets(top: 0,
                                                                                       leading: 10,
                                                                                       bottom: 0,
                                                                                       trailing: 10))
        
        let groupType = MainGroupType(groupSize: GroupSize(width: 1, height: 1.6),
                                      isDirectionVertical: true,
                                      item: item,
                                      itemCount: 8)
        
        let group = LayoutManager().configureGroup(groupType: groupType)
        
        let sectionHeader = LayoutManager().configureHeader(GroupSize(width: 1.0, height: 0.17),
                                                            elementKind: MainViewController.sectionHeaderElementKind)
        
        let sectionType = MainSectionType(group: group,
                                          header: sectionHeader)
        
        let section = LayoutManager().configureSection(sectionType: sectionType)
        return section
    }
}

extension SearchDetailViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dump(searchController.searchBar.text)
        // TODO: input에 맞게 검색어 자동완성 추천 구현
        guard let text = searchController.searchBar.text else {
            return
        }
    }
}

extension SearchDetailViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // TODO: 자동검색 화면 보여주기
        coordinator?.coordinateToSearchDetail()
        return true
    }
}
