//
//  Extenxions.swift
//  Slideshow
//
//  Created by Daniel Hjärtström on 2018-11-19.
//  Copyright © 2018 Sog. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: type(of: self))
    }
}
