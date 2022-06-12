//
//  CalendarDiffableDataSource.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/12.
//

import UIKit

final class CalendarDiffableDataSource: UICollectionViewDiffableDataSource<CalendarSection, CalendarItem> {
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView
            .dequeueReusableSupplementaryView(ofKind: kind,
                                              withReuseIdentifier: String(describing: CalendarHeaderView.self),
                                              for: indexPath) as? CalendarHeaderView else {
            return UICollectionReusableView()
        }
        
        supplementaryView.configureHeaderView(year: 2022, month: 9)
        return supplementaryView
    }
}
