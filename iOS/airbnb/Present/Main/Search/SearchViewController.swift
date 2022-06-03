//
//  SearchController.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/03.
//

import UIKit

class SearchViewController: UISearchController {

    var coordinate: SearchFlow?
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setUp() {
        searchBar.placeholder = "어디로 여행가세요?"
        self.obscuresBackgroundDuringPresentation = true
        searchResultsUpdater = self
        searchBar.delegate = self
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dump(searchController.searchBar.text)
        // TODO: input에 맞게 검색어 자동완성 추천 구현
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // TODO: 검색 프리뷰 화면 보여주기
        coordinate?.coordinateToSearchPreview()
        return true
    }
}
