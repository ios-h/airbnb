//
//  SearchResultViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/06.
//

import UIKit

class SearchResultViewController: UIViewController {

    private var searchResultTableView: UITableView! = nil
    private lazy var dataSource: SearchResultTableViewDataSource = SearchResultTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        configureTableView()
    }
    
    private func configureTableView() {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.register(SearchResultTableViewCell.self,
                           forCellReuseIdentifier: String(describing: SearchResultTableViewCell.self))
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        searchResultTableView = tableView
    }
}

extension SearchResultViewController: UITableViewDelegate {
    
}
