//
//  SlideView.swift
//  Slideshow
//
//  Created by Daniel Hjärtström on 2018-11-19.
//  Copyright © 2018 Sog. All rights reserved.
//

import UIKit

class SlideView: UIView {
    
    var hasTimer: Bool = false {
        didSet {
            if hasTimer {
                runTimer()
            }
        }
    }
    
    private var currentIndex: Int = 0 {
        didSet {
            pageControl.currentPage = currentIndex
        }
    }
    
    private var items = [Any]()
    private var timer: Timer?
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let temp = UICollectionViewFlowLayout()
        temp.minimumInteritemSpacing = 0
        temp.minimumLineSpacing = 0
        temp.scrollDirection = .horizontal
        return temp
    }()
    
    private lazy var collectionView: UICollectionView = {
        let temp = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        temp.delegate = self
        temp.dataSource = self
        temp.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        temp.isPagingEnabled = true
        temp.backgroundColor = UIColor.clear
        temp.showsVerticalScrollIndicator = false
        temp.showsHorizontalScrollIndicator = false
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return temp
    }()
    
    private lazy var pageControl: UIPageControl = {
        let temp = UIPageControl()
        temp.currentPage = 0
        temp.currentPageIndicatorTintColor = UIColor.white
        temp.pageIndicatorTintColor = UIColor.lightGray
        temp.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        insertSubview(temp, aboveSubview: collectionView)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return temp
    }()
    
    convenience init(frame: CGRect, items: [UIImage]) {
        self.init(frame: frame)
        self.items = items
        commonConvenienceInit()
    }
    
    convenience init(frame: CGRect, items: [String]) {
        self.init(frame: frame)
        self.items = items
        commonConvenienceInit()
    }
    
    convenience init(frame: CGRect, items: [URL]) {
        self.init(frame: frame)
        self.items = items
        commonConvenienceInit()
    }
    
    private func commonConvenienceInit() {
        pageControl.numberOfPages = items.count
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureFrames()
    }
    
    private func configureFrames() { }

    private func commonInit() {
        backgroundColor = UIColor.black
        pageControl.isHidden = false
        collectionView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeOrientation), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc private func didChangeOrientation() {
        if bounds.width != 0 {
            collectionViewLayout.invalidateLayout()
            collectionViewLayout.itemSize = CGSize(width: bounds.width, height: bounds.height)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension SlideView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        let item = items[indexPath.row]
        cell.setupWithItem(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width, height: bounds.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageControl()
    }
    
    private func updatePageControl() {
        guard let visibleCells = collectionView.visibleCells.first else { return }
        guard let selectedIndexPath = collectionView.indexPath(for: visibleCells) else { return }
        currentIndex = selectedIndexPath.row
    }
    
}

extension SlideView {
    private func runTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { (timer) in
            self.changeImage()
        })
    }
    
    private func changeImage() {
        let nextIndex = currentIndex + 1
        
        if nextIndex > items.count - 1 {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
            currentIndex = 0
        } else {
            collectionView.scrollToItem(at: IndexPath(item: nextIndex, section: 0), at: .right, animated: true)
            currentIndex = nextIndex
        }
    }
}
