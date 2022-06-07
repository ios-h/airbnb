//
//  WishListCollectionViewDataSource.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/07.
//

import UIKit

final class WishListCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
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
        cell.configure(with: WishListModel(image: item.image,
                                          rating: item.rating,
                                          reviewCount: item.reviewCount,
                                          accomodationName: item.accomodationName,
                                          price: item.price))
        return cell
    }
}
