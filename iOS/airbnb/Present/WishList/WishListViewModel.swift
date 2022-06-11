//
//  WishListViewModel.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/10.
//

import Alamofire
import Foundation

class WishListViewModel {
    var wishListItems = [WishListModel]()
    
    private func dataToModel(responseData: WishListResponseData) {
        for data in responseData.data {
            let rating = Double.random(in: 3.00...5.00)
            let reviewCount = Int.random(in: 1...100)
            let model = WishListModel(id: data.wishId,
                                      imageUrls: data.imagesUrls,
                                      rating: round(rating * 100) / 100,
                                      reviewCount: reviewCount,
                                      accomodationName: data.name,
                                      price: data.price)
            wishListItems.append(model)
        }
    }
    
    func getWishList(completion: @escaping () -> Void) {
        let url = "\(Constant.urlString)/api/wishlist?customerId=1"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: [
                    "Authorization": Constant.tempToken,
                    "Content-Type": "application/json",
                    "Accept": "application/json"])
        .validate(statusCode: 200..<300)
        .responseDecodable(of: WishListResponseData.self) { response in
            switch response.result {
            case .success(let response):
                self.dataToModel(responseData: response)
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
}
