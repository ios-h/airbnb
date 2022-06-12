//
//  WishListCollectionViewDataSource.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/07.
//

import Alamofire
import UIKit

final class WishListCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return !wishListItems.isEmpty ? wishListItems.count: MockDataModel.mockWishListItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: String(describing: WishListCollectionViewCell.self),
                                 for: indexPath) as? WishListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if !wishListItems.isEmpty {
            let item = wishListItems[indexPath.item]
            cell.configure(with: item)
            return cell
        }
        
        let item = MockDataModel.mockWishListItems[indexPath.item]
        cell.configure(with: item)
        return cell
    }

    init(wishListItems: [WishListModel]) {
        self.wishListItems = wishListItems
    }
    
    private var wishListItems: [WishListModel]
}
