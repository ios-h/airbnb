//
//  MainSectionDiffableDataSource.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/31.
//

import UIKit

class MainSectionDiffableDataSource: UICollectionViewDiffableDataSource<MainSection, MainImageItem> {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView
            .dequeueReusableSupplementaryView(ofKind: kind,
                                              withReuseIdentifier: String(describing: CommonHeaderView.self),
                                              for: indexPath) as? CommonHeaderView else {
            return UICollectionReusableView()
        }
        supplementaryView.headerLabel.text = MainSection.allCases[indexPath.section].rawValue
        return supplementaryView
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = MainSection.allCases[indexPath.section]
        
        guard let itemIdentifier = itemIdentifier(for: indexPath) else { return UICollectionViewCell() }
        
        switch sectionType {
        case .heroImage:
            return heroSectionType(collectionView: collectionView,
                                   indexPath: indexPath,
                                   detailItem: itemIdentifier)
        case .nearestDestination:
            return nearestSectionType(collectionView: collectionView,
                                      indexPath: indexPath,
                                      detailItem: itemIdentifier)
        case .accomodation:
            return accomodationSectionType(collectionView: collectionView,
                                           indexPath: indexPath,
                                           detailItem: itemIdentifier)
        }
    }
    
    private func heroSectionType(collectionView: UICollectionView,
                                 indexPath: IndexPath,
                                 detailItem: MainImageItem) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: HeroImageCollectionViewCell.self),
            for: indexPath) as? HeroImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.titleLabel.text = detailItem.title
        cell.heroImageView.image = UIImage(named: "\(detailItem.imageName)")
        cell.isDataSourceConfigured = true
        return cell
    }
    
    private func nearestSectionType(collectionView: UICollectionView,
                                    indexPath: IndexPath,
                                    detailItem: MainImageItem) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: NearestDestinationCollectionViewCell.self),
            for: indexPath) as? NearestDestinationCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.titleLabel.text = detailItem.title
        cell.detailLabel.text = "차로 30분 거리"
        cell.cityImageView.image = UIImage(named: "img_hero_jeju")
        cell.isDataSourceConfigured = true
        return cell
    }
    
    private func accomodationSectionType(collectionView: UICollectionView,
                                         indexPath: IndexPath,
                                         detailItem: MainImageItem) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: MainAccomodationCollectionViewCell.self),
            for: indexPath) as? MainAccomodationCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.detailLabel.text = "자연생활을 만끼할 수\n있는 숙소"
        cell.accomodationImageView.image = UIImage(named: "img_hero_beach")
        cell.isDataSourceConfigured = true
        return cell
    }
}
