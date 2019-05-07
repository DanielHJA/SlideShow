//
//  ImageCollectionViewCell.swift
//  Slideshow
//
//  Created by Daniel Hjärtström on 2018-11-19.
//  Copyright © 2018 Sog. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .scaleAspectFill
        temp.clipsToBounds = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return temp
    }()
    
    func setupWithItem(_ item: Any) {
        if let item = item as? UIImage {
            setupWithItem(item)
        }
        if let item = item as? String {
            setupWithItem(item)
        }
        if let item = item as? URL {
            setupWithItem(item)
        }
    }
    
    func setupWithItem(_ item: UIImage) {
        imageView.image = item
    }
    
    func setupWithItem(_ item: String) {
        imageView.image = UIImage(named: item)
    }
    
    func setupWithItem(_ item: URL) {
        imageView.kf.setImage(with: item)
    }
    
}
