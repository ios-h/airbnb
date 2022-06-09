//
//  WeekdayCollectionViewDataSource.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/09.
//

import UIKit

final class WeekdayCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: String(describing: CalendarCollectionViewCell.self),
                                 for: indexPath) as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let dayString = CalendarViewModel.weeks[indexPath.item]
        cell.textLabel.text = dayString
        return cell
    }
}
