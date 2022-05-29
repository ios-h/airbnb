//
//  MainViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/24.
//

import UIKit

class MainViewController: UIViewController, MainFlow {
    
    private let heroImageView: UIImageView = {
        guard let image = UIImage(named: "img_hero") else {
            return UIImageView(image: UIImage(named: ""))
        }
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemMint
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let titleLabel = CustomLabel(numberOfLines: 0,
                                         color: .customBlack!,
                                         attributedString: NSMutableAttributedString(string: "슬기로운\n자연생활"),
                                         font: .systemFont(ofSize: 34, weight: .medium))
    
    private let detailLabel = CustomLabel(numberOfLines: 0,
                                          color: .gray1!,
                                          attributedString:
                                            NSMutableAttributedString(string: "에어비앤비가 엄선한\n위시리스트를 만나보세요."),
                                          font: .systemFont(ofSize: 17, weight: .medium))
    
    private let ideaButton = CustomButton(title: "여행 아이디어 얻기",
                                          state: .normal,
                                          titleColor: .white!,
                                          backgroundColor: .black,
                                          font: .systemFont(ofSize: 17, weight: .bold))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray6
        
        setUpSearchController()
        
        addViews()
        setLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setLayout()
    }
    
    private func setUpSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "어디로 여행가세요?"
        searchController.obscuresBackgroundDuringPresentation = false // true이면 검색 중 뒷 배경 모두 흐릿하게 해줌
        
        self.navigationItem.searchController = searchController
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(heroImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(detailLabel)
        scrollView.addSubview(ideaButton)
    }
    
    private func setLayout() {
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        heroImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        heroImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        heroImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        heroImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: heroImageView.bottomAnchor).isActive = true
    
        titleLabel.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: heroImageView.topAnchor, constant: 20).isActive = true
        
        detailLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        ideaButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        ideaButton.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 20).isActive = true
        ideaButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.5).isActive = true
        ideaButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
