//
//  WishListModel.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/08.
//

import Foundation
import UIKit.UIImage

struct WishListModel {
    let id: Int
    private(set) var image: UIImage? = UIImage(named: "img_gosim")
    private(set) var imageUrls: [String]? = ["https://i.imgur.com/jujj5QL.jpg"]
    let rating: Double?
    let reviewCount: Int?
    let accomodationName: String
    let price: Int
}
