//
//  HeroImageItem.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/30.
//

import Foundation

class HeroImageItem: Hashable {
    let imageName: String
    let title: String
    
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: HeroImageItem, rhs: HeroImageItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}
