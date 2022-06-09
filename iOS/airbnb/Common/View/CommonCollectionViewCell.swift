//
//  MainCollectionViewCell.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/05.
//

import UIKit

class CommonCollectionViewCell: UICollectionViewCell {
   
    public let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
}
