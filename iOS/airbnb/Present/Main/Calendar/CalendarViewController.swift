//
//  CalendarViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/08.
//

import UIKit

final class CalendarViewController: UIViewController {

    var coordinator: CalendarFlow?
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    private let viewModel: CalendarViewModel = CalendarViewModel()
    
    private var weekdayListCollectionView: UICollectionView! = nil
    private var calendarCollectionView: UICollectionView! = nil
    
    private var weekdayCollectionViewDataSource = WeekdayCollectionViewDataSource()
    private var calendarCollectionViewDataSource: CalendarDiffableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureWeekdayCollectionView()
        configureCalendarCollectionView()
        
        configureDataSource()
        configureCalendarCollectionViewDataSource()
        
        configure()
        bind()
    }
    
    private func bind() {
//        viewModel
    }
    
    private func configure() {
        self.navigationItem.title = "숙소 찾기"
        
        view.addSubview(weekdayListCollectionView)
        view.addSubview(calendarCollectionView)
        
        weekdayListCollectionView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.bounds.width / 6)
        }
        
        calendarCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(weekdayListCollectionView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureWeekdayCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
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
    
    private func configureCalendarCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .white
        collectionView.register(
            CalendarCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: CalendarCollectionViewCell.self))
        collectionView.register(
            CalendarHeaderView.self,
            forSupplementaryViewOfKind: CalendarViewController.sectionHeaderElementKind,
            withReuseIdentifier: String(describing: CalendarHeaderView.self))
        calendarCollectionView = collectionView
    }
    
    private func configureCalendarCollectionViewDataSource() {
        calendarCollectionViewDataSource = CalendarDiffableDataSource(
            collectionView: calendarCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let sectionType = CalendarSection.allCases[indexPath.section]
            
            switch sectionType {
            case .calendar:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: CalendarCollectionViewCell.self),
                    for: indexPath) as? CalendarCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.textLabel.text = "\(itemIdentifier.day)"
                return cell
            }
        })
        
        let snapshot = snapshotForCurrentState()
        calendarCollectionViewDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<CalendarSection, CalendarItem> {
        var snapshot = NSDiffableDataSourceSnapshot<CalendarSection, CalendarItem>()
        snapshot.appendSections([CalendarSection.calendar])
        snapshot.appendItems(itemsForCalendarCollectionView())
        return snapshot
    }
    
    private func itemsForCalendarCollectionView() -> [CalendarItem] {
        return MockDataModel.calendarItems
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/7),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(1/7))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        let sectionHeader = LayoutManager.configureHeader(GroupSize(width: .fractionalWidth(1.0),
                                                                    height: .fractionalWidth(1/7)),
                                                          elementKind: MainViewController.sectionHeaderElementKind)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
