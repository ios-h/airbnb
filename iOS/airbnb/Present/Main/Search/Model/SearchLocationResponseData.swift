//
//  SearchLocationResponseData.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/10.
//

import Foundation

struct SearchLocationResponseData: Codable {
    let data: [SearchLocationData]
}

struct SearchLocationData: Codable {
    let id: Int
    let name: String
    let price: Int
    let longitude: Double
    let latitude: Double
    let address: String
    let type: String
    let description: String
    let maxGuest: Int
    let numberOfRoom: Int
    let numberOfBed: Int
    let numberOfBathroom: Int
    let imageUrls: [String]
}
