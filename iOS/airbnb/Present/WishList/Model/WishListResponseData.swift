//
//  WishListResponseData.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/10.
//

import Foundation

struct WishListResponseData: Codable {
    let data: [WishListData]
}

struct WishListData: Codable {
    let accommodationId: Int
    let name: String
    let price: Int
    let imageUrls: [String]
    let wishId: Int
    let isWish: Bool
}
