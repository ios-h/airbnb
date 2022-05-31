//
//  SearchDiffableDataSource.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/31.
//

import UIKit

class SearchDiffableDataSource: UICollectionViewDiffableDataSource<SearchSection, SearchItem> {
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView
            .dequeueReusableSupplementaryView(ofKind: kind,
                                              withReuseIdentifier: String(describing: CommonHeaderView.self),
                                              for: indexPath) as? CommonHeaderView else {
            return UICollectionReusableView()
        }
        supplementaryView.headerLabel.text = SearchSection.allCases[indexPath.section].rawValue
        return supplementaryView
    }
}
