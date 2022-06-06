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
        
        let mainViewCell = MainViewCell(collectionView: collectionView,
                                        indexPath: indexPath,
                                        detailItem: itemIdentifier)
        
        switch sectionType {
        case .heroImage:
            return heroSectionType(mainViewCell: mainViewCell)
        case .nearestDestination:
            return nearestSectionType(mainViewCell: mainViewCell)
        case .accomodation:
            return accomodationSectionType(mainViewCell: mainViewCell)
        }
    }
    
    private func heroSectionType(mainViewCell: MainViewCell) -> UICollectionViewCell {
        let collectionView = mainViewCell.collectionView
        let indexPath = mainViewCell.indexPath
        let detailItem = mainViewCell.detailItem
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: HeroImageCollectionViewCell.self),
            for: indexPath) as? HeroImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        configureCell(with: cell, indexPath: indexPath, detailItem: detailItem)
        return cell
    }
    
    private func configureCell(with cell: HeroImageCollectionViewCell,
                               indexPath: IndexPath,
                               detailItem: MainImageItem) {
        cell.titleLabel.text = detailItem.title
        cell.imageView.image = UIImage(named: "\(detailItem.imageName)")
        cell.isDataSourceConfigured = true
    }
    
    private func nearestSectionType(mainViewCell: MainViewCell) -> UICollectionViewCell {
        let collectionView = mainViewCell.collectionView
        let indexPath = mainViewCell.indexPath
        let detailItem = mainViewCell.detailItem
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: NearestDestinationCollectionViewCell.self),
            for: indexPath) as? NearestDestinationCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        configureCell(with: cell, indexPath: indexPath, detailItem: detailItem)
        return cell
    }
    
    private func configureCell(with cell: NearestDestinationCollectionViewCell,
                               indexPath: IndexPath,
                               detailItem: MainImageItem) {
        cell.titleLabel.text = detailItem.title
        cell.detailLabel.text = "차로 30분 거리"
        cell.cityImageView.image = UIImage(named: "img_hero_jeju")
        cell.isDataSourceConfigured = true
    }
    
    private func accomodationSectionType(mainViewCell: MainViewCell) -> UICollectionViewCell {
        let collectionView = mainViewCell.collectionView
        let indexPath = mainViewCell.indexPath
        let detailItem = mainViewCell.detailItem
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: MainAccomodationCollectionViewCell.self),
            for: indexPath) as? MainAccomodationCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        configureCell(with: cell, indexPath: indexPath, detailItem: detailItem)
        return cell
    }
    
    private func configureCell(with cell: MainAccomodationCollectionViewCell,
                               indexPath: IndexPath,
                               detailItem: MainImageItem) {
        cell.detailLabel.text = "자연생활을 만끽할 수\n있는 숙소"
        cell.accomodationImageView.image = UIImage(named: "img_hero_beach")
        cell.isDataSourceConfigured = true
    }
    
    class MainViewCell {
        let collectionView: UICollectionView
        let indexPath: IndexPath
        let detailItem: MainImageItem
        
        init(collectionView: UICollectionView, indexPath: IndexPath, detailItem: MainImageItem) {
            self.collectionView = collectionView
            self.indexPath = indexPath
            self.detailItem = detailItem
        }
    }
    
    class MainCellContent {
        let title: String
        let content: String
        let imageName: String
        let isDataSourceConfigured: Bool
        
        init(title: String, content: String, imageName: String, isDataSourceConfigured: Bool) {
            self.title = title
            self.content = content
            self.imageName = imageName
            self.isDataSourceConfigured = isDataSourceConfigured
        }
    }
}
