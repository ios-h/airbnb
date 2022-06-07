//
//  ReservationCollectionViewDataSource.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/08.
//

import UIKit

final class ReservationCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MockDataModel.mockReservationItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: String(describing: ReservationCollectionViewCell.self),
                                 for: indexPath) as? ReservationCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = MockDataModel.mockReservationItems[indexPath.item]
        cell.configure(with: ReservationModel(image: item.image,
                                              duration: item.duration,
                                              location: item.location,
                                              roomType: item.roomType))
        return cell
    }
}
