//
//  CalendarCollectionViewDataSource.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/08.
//

import UIKit

final class CalendarCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MockDataModel.mockWishListItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: String(describing: WishListCollectionViewCell.self),
                                 for: indexPath) as? WishListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = MockDataModel.mockWishListItems[indexPath.item]
        cell.configure(with: item)
        return cell
    }
}
