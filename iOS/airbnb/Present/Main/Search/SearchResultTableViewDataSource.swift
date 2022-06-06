//
//  SearchResultTableViewDataSource.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/07.
//

import MapKit
import UIKit

final class SearchResultTableViewDataSource: NSObject, UITableViewDataSource, SearchResultDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completerResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        String(describing: SearchResultTableViewCell.self),
                                                       for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        
        configureCell(cell: cell, indexPath: indexPath)
        print("셀!!", cell.cityNameLabel)
        return cell
    }
    
    private func configureCell(cell: SearchResultTableViewCell, indexPath: IndexPath) {
        if let suggestion = completerResults?[indexPath.row] {
            cell.cityNameLabel.text = suggestion.title
            cell.isDataSourceConfigured = true
            print("title", suggestion.title)
            print("subtitle", suggestion.subtitle)
        }
    }
    
    func getCompleterResult(completerResults: [MKLocalSearchCompletion]?) {
        self.completerResults = completerResults
        print("aaaa", completerResults)
        print("aaaaaa", completerResults?.count)
    }
    
    init(delegate: SearchResultDelegate?) {
        self.delegate = delegate
    }
    
    private weak var delegate: SearchResultDelegate?
    private var completerResults: [MKLocalSearchCompletion]?
}
