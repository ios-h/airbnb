//
//  ReservationViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/24.
//

import UIKit

final class ReservationViewController: UIViewController {

    var coordinate: ReservationFlow?
    
    private var reservationCollectionView: UICollectionView! = nil
    private var dataSource = ReservationCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureCollectionView()
        configureDataSource()
        
        configure()
    }
    
    private func configure() {
        self.navigationItem.title = "내 예약"
        
        view.addSubview(reservationCollectionView)
        
        reservationCollectionView.leadingAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        reservationCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        reservationCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        reservationCollectionView.bottomAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
        
        collectionView.register(ReservationCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: ReservationCollectionViewCell.self))
        reservationCollectionView = collectionView
    }
    
    func configureDataSource() {
        reservationCollectionView.dataSource = dataSource
    }
}
