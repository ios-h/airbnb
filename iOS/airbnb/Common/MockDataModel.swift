//
//  MockDataModel.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/30.
//

import Foundation
import UIKit

struct MockDataModel {
    static let mockHeroImages = [MainImageItem(title: "슬기로운 자연생활", imageName: "img_hero"),
                                 MainImageItem(title: "바다로 떠나요", imageName: "img_hero_beach"),
                                 MainImageItem(title: "우리의 제주", imageName: "img_hero_jeju"),
                                 MainImageItem(title: "슬기로운 숲 속 생활", imageName: "img_hero"),
                                 MainImageItem(title: "바다 어때요?", imageName: "img_hero_beach"),
                                 MainImageItem(title: "제주로 떠나요", imageName: "img_hero_jeju")]
    
    static let mockSearchItems = [SearchItem(imageName: "img_hero", title: "서울", description: "차로 30분 거리"),
                                 SearchItem(imageName: "img_hero_beach", title: "광주", description: "차로 4시간 거리"),
                                 SearchItem(imageName: "img_hero_jeju", title: "의정부시", description: "차로 30분 거리"),
                                 SearchItem(imageName: "img_hero", title: "수원시", description: "차로 45분 거리"),
                                 SearchItem(imageName: "img_hero_beach", title: "서울", description: "차로 30분 거리"),
                                 SearchItem(imageName: "img_hero_jeju", title: "제주", description: "비행기로 30분 거리"),
                                 SearchItem(imageName: "img_hero", title: "대구", description: "차로 3시간 거리"),
                                 SearchItem(imageName: "img_hero_beach", title: "부산", description: "차로 5시간 거리"),
                                 SearchItem(imageName: "img_hero_jeju", title: "대전", description: "차로 2시간 거리"),
                                 SearchItem(imageName: "img_hero", title: "부천시", description: "차로 30분 거리")]
    
    static let mockWishListItems = [
        WishListModel(image: UIImage(named: "img_thumbnail1"),
                     rating: 4.98,
                     reviewCount: 50,
                     accomodationName: "비담집, 비우고 담은집(집전체, 최대4인)",
                     price: 308_571),
        WishListModel(image: UIImage(named: "img_thumbnail2"),
                     rating: 4.96,
                     reviewCount: 157,
                     accomodationName: "HOTEL강릉세인트존스호텔 풀오션뷰 ...",
                     price: 131_429),
        WishListModel(image: UIImage(named: "img_thumbnail1"),
                     rating: 4.98,
                     reviewCount: 50,
                     accomodationName: "비담집, 비우고 담은집(집전체, 최대4인)",
                     price: 308_571),
        WishListModel(image: UIImage(named: "img_thumbnail2"),
                     rating: 4.96,
                     reviewCount: 157,
                     accomodationName: "HOTEL강릉세인트존스호텔 풀오션뷰 ...",
                     price: 131_429)]
}
