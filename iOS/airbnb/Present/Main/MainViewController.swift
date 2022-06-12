//
//  MainViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/24.
//

import SnapKit
import UIKit
import WebKit

final class MainViewController: UIViewController {
    
    let mainViewModel = MainViewModel()
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    var coordinate: MainFlow?
    
    private var mainCollectionView: UICollectionView! = nil
    private var dataSource: MainSectionDiffableDataSource!

    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private lazy var loginButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "로그인",
                                     style: .plain,
                                     target: self,
                                     action: #selector(loginButtonTapped(_:)))
        return button
    }()
    
    @objc private func loginButtonTapped(_ sender: Any) {
        setupWebView()
        
        let githubUrl = "http://52.79.106.69:8080/login"
        if let url = URL(string: githubUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
        alert(title: "알림", message: "로그인 되었습니다.", okTitle: "확인")
        
        loginButton.title = "로그아웃"
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpSearchController()
        configureCollectionView()
        configureDataSource()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        configureDataSource()
    }
    
    private func setUpSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "어디로 여행가세요?"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        self.navigationItem.title = "Airbnb"
        self.navigationItem.searchController = searchController
        self.navigationItem.rightBarButtonItem = loginButton
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .white
        collectionView.register(
            HeroImageCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: HeroImageCollectionViewCell.self))
        collectionView.register(
            NearestDestinationCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: NearestDestinationCollectionViewCell.self))
        collectionView.register(
            MainAccomodationCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: MainAccomodationCollectionViewCell.self))
        collectionView.register(
            CommonHeaderView.self,
            forSupplementaryViewOfKind: MainViewController.sectionHeaderElementKind,
            withReuseIdentifier: String(describing: CommonHeaderView.self))
        mainCollectionView = collectionView
    }
    
    private func configureDataSource() {
        dataSource = MainSectionDiffableDataSource(collectionView: mainCollectionView,
                                                   cellProvider: { _, _, _ in
            return UICollectionViewCell()
        })
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<MainSection, MainImageItem> {
        var snapshot = NSDiffableDataSourceSnapshot<MainSection, MainImageItem>()
        snapshot.appendSections([MainSection.heroImage])
        snapshot.appendItems(Array(itemsForHeroImageSection().prefix(3)))
        
        snapshot.appendSections([MainSection.nearestDestination])
        snapshot.appendItems(itemsForNearestDestinationSection().suffix(3))
        
        snapshot.appendSections([MainSection.accomodation])
        snapshot.appendItems(itemsForAccomodationSection())
        return snapshot
    }
    
    private func itemsForHeroImageSection() -> [MainImageItem] {
        return MockDataModel.mockHeroImages // 섹션에 이 갯수만큼 아이템들이 나온다.
    }
    
    private func itemsForNearestDestinationSection() -> [MainImageItem] {
        return MockDataModel.mockHeroImages
    }
    
    private func itemsForAccomodationSection() -> [MainImageItem] {
        return [MainImageItem(title: "슬기로운 자연생활", imageName: "img_hero"),
                MainImageItem(title: "바다로 떠나요", imageName: "img_hero_beach")]
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout =
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = MainSection.allCases[sectionIndex]
            let section = self.generateSection(sectionLayoutKind: sectionLayoutKind)
            return section
        }
        return layout
    }
    
    private func generateSection(sectionLayoutKind: MainSection) -> NSCollectionLayoutSection {
        switch sectionLayoutKind {
        case .heroImage:
            return mainViewModel.generateHeroImageSection()
        case .nearestDestination:
            return mainViewModel.generateNearestDestinationSection()
        case .accomodation:
            return mainViewModel.generateAccomodationSection()
        }
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dump(searchController.searchBar.text)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        coordinate?.coordinateToSearchViewController()
        return true
    }
}

extension MainViewController: WKUIDelegate {
}
