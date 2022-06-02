//
//  SearchItem.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/31.
//

import Foundation

class SearchItem: Hashable {
    let imageName: String
    let title: String
    let description: String
    
    init(imageName: String, title: String, description: String) {
        self.imageName = imageName
        self.title = title
        self.description = description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: SearchItem, rhs: SearchItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}

enum SearchSection: String, CaseIterable {
    case nearestPopularDestination = "근처의 인기 여행지"
}
