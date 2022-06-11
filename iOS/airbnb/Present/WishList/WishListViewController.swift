//
//  WishListViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/24.
//

import Alamofire
import UIKit

final class WishListViewController: UIViewController {

    var coordinate: WishListFlow?
    
    private var wishListCollectionView: UICollectionView! = nil
    private lazy var dataSource: WishListCollectionViewDataSource = {
        let dataSource =
        WishListCollectionViewDataSource(wishListItems:
                                            wishListItems ?? MockDataModel.mockWishListItems)
        return dataSource
    }()
    
    private let viewModel = WishListViewModel()
    private var wishListItems: [WishListModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        viewModel.getWishList {
            self.wishListItems = self.viewModel.wishListItems
            
            self.configureCollectionView()
            self.configureDataSource()
            
            self.configure()
        }
    }
    
    private func configure() {
        self.navigationItem.title = "위시리스트"
        
        view.addSubview(wishListCollectionView)
        
        wishListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        wishListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        wishListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        wishListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func configureCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        flowLayout.minimumLineSpacing = 50
        flowLayout.itemSize = CGSize(width: view.bounds.width * 0.9, height: view.bounds.width * 0.9)
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.clipsToBounds = true
        collectionView.showsVerticalScrollIndicator = true
        
        collectionView.register(WishListCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: WishListCollectionViewCell.self))
        wishListCollectionView = collectionView
    }
    
    func configureDataSource() {
        wishListCollectionView.dataSource = dataSource
    }
}
