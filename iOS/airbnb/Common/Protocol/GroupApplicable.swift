//
//  GroupApplicable.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/09.
//

import UIKit

protocol GroupApplicable {
    var groupSize: GroupSize { get }
    var groupInset: NSDirectionalEdgeInsets { get }
    var isDirectionVertical: Bool { get }
    var item: NSCollectionLayoutItem { get }
    var itemCount: Int { get }
}
