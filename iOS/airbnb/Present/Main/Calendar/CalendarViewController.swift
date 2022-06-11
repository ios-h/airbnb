//
//  CalendarViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/08.
//

import UIKit

final class CalendarViewController: UIViewController {

    var coordinator: CalendarFlow?
    
    private let viewModel: CalendarViewModel = CalendarViewModel()
    
    private var weekdayListCollectionView: UICollectionView! = nil
    private var calendarCollectionView: UICollectionView! = nil
    
    private var weekdayCollectionViewDataSource = WeekdayCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureCollectionView()
        configureDataSource()
        configure()
        bind()
    }
    
    private func bind() {
//        viewModel
    }
    
    private func configure() {
        self.navigationItem.title = "숙소 찾기"
        
        view.addSubview(weekdayListCollectionView)
        
        weekdayListCollectionView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(90)
        }
    }
    
    private func configureCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.minimumLineSpacing = 10
        flowLayout.itemSize = CGSize(width: view.bounds.width / 9, height: view.bounds.width / 9)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        collectionView.clipsToBounds = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CalendarCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: CalendarCollectionViewCell.self))
        weekdayListCollectionView = collectionView
    }
    
    private func configureDataSource() {
        weekdayListCollectionView.dataSource = weekdayCollectionViewDataSource
    }
}
