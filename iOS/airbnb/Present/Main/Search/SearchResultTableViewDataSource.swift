//
//  SearchResultTableViewDataSource.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/07.
//

import UIKit

final class SearchResultTableViewDataSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        String(describing: SearchResultTableViewCell.self),
                                                       for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        configureCell(cell: cell, indePath: indexPath)
        return cell
    }
    
    private func configureCell(cell: SearchResultTableViewCell, indePath: IndexPath) {
        cell.cityNameLabel.text = "도시 이름"
        cell.isDataSourceConfigured = true
    }
}
