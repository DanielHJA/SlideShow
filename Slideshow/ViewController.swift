//
//  ViewController.swift
//  Slideshow
//
//  Created by Daniel Hjärtström on 2018-11-19.
//  Copyright © 2018 Sog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var images: [UIImage] {
        return [
            UIImage(named: "1")!,
            UIImage(named: "2")!,
            UIImage(named: "3")!
        ]
    }
    
    private var urlImages: [URL] {
        return [
            URL(string: "https://images.pexels.com/photos/248797/pexels-photo-248797.jpeg?auto=compress&cs=tinysrgb&h=350")!,
            URL(string: "https://wallpaperbrowse.com/media/images/soap-bubble-1958650_960_720.jpg")!,
            URL(string: "https://images.pexels.com/photos/257840/pexels-photo-257840.jpeg?auto=compress&cs=tinysrgb&h=350")!
        ]
    }
    
    private var imageStrings: [String] = ["1","2","3"]
    
    private lazy var slideView: SlideView = {
        let temp = SlideView(frame: CGRect.zero, items: urlImages)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.hasTimer = true
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        slideView.isHidden = false
    }

}

