//
//  ZZCycleScrollView.swift
//  ZZCycleScrollView
//
//  Created by Zhang on 2018/1/12.
//  Copyright © 2018年 LuckyDog. All rights reserved.
//

import UIKit

protocol ZZCycleScrollViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: ZZCycleScrollView, didSelectItemAtIndex index: NSInteger)   -> Void
    
    func cycleScrollView(_ cycleScrollView: ZZCycleScrollView, didScrollToIndex index: NSInteger)   -> Void
}

private let cellId: String = "cell"
private let baseNumber: NSInteger = 100

class ZZCycleScrollView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    /// delegate
    var delegate: ZZCycleScrollViewDelegate?
    
    /// 本地图片 url string 数组
    var localizationImageNamesGroup: NSArray = NSArray.init() {
        didSet {
           imagePathsGroup = localizationImageNamesGroup.copy() as! NSArray
           totalItemsCount = imagePathsGroup.count * baseNumber
           pageControl?.numberOfPages = imagePathsGroup.count;
        }
    }
    
    /// 网络图片 url string 数组
    var imageURLStringsGroup: NSArray = NSArray.init() {
        didSet {
            
        }
    }
    
    private var imagePathsGroup: NSArray = NSArray.init()
    private var totalItemsCount: NSInteger = 0
    
    private var mainView: UICollectionView?
    private var flowLayout: UICollectionViewFlowLayout?
    private var pageControl: UIPageControl?
    
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initMainView()
        self.initPageControl()
        self.initTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// mainView
    func initMainView() -> Void {
        flowLayout = UICollectionViewFlowLayout.init()
        flowLayout!.scrollDirection = .horizontal
        flowLayout!.minimumLineSpacing = 0
        flowLayout!.minimumInteritemSpacing = 0
        
        mainView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout!)
        mainView!.backgroundColor = UIColor.clear
        mainView!.isPagingEnabled = true
        mainView!.showsVerticalScrollIndicator = false
        mainView!.showsHorizontalScrollIndicator = false
        mainView!.register(ZZCollectionViewCell.classForCoder(), forCellWithReuseIdentifier:cellId)
        mainView!.delegate = self
        mainView!.dataSource = self
        self.addSubview(mainView!)
    }
    
    func initPageControl() -> Void {
        if pageControl != nil {
            pageControl?.removeFromSuperview()
        }
        pageControl = UIPageControl.init()
        pageControl!.pageIndicatorTintColor = UIColor.white
        pageControl!.currentPageIndicatorTintColor = UIColor.lightGray
        self.addSubview(pageControl!)
    }
    
    func initTimer() -> Void {
       self.invalidateTimer()
       timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(automaticScroll), userInfo: nil, repeats: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainView?.frame = self.bounds
        flowLayout!.itemSize = self.bounds.size
        pageControl?.frame.origin = CGPoint.init(x: self.bounds.size.width / 2, y: self.bounds.size.height - 10)
    }
    
    //MARK:UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ZZCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ZZCollectionViewCell
        let itemIndex: NSInteger = self.pageControlIndexWithCurrentCellIndex(index: indexPath.item)
        cell.imageView?.image = UIImage.init(named: imagePathsGroup[itemIndex] as! String)
        return cell
    }
    
    //MARK:UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if imagePathsGroup.count == 0 {
            return
        }
        pageControl?.currentPage = self.pageControlIndexWithCurrentCellIndex(index: self.currentIndex())
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.invalidateTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.initTimer()
    }
    
    @objc func automaticScroll() -> Void {
        if totalItemsCount == 0 {
            return
        }
        self.scrollToIndex(targetIndex: self.currentIndex() + 1)
    }
    
    func invalidateTimer() -> Void {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollToIndex(targetIndex: NSInteger) -> Void {
        if targetIndex >= totalItemsCount {
            mainView?.scrollToItem(at: IndexPath.init(item: totalItemsCount/2, section: 0), at: UICollectionViewScrollPosition.init(rawValue: 0), animated: false)
            return
        }
        mainView?.scrollToItem(at: IndexPath.init(item: targetIndex, section: 0), at: UICollectionViewScrollPosition.init(rawValue: 0), animated: true)
    }
    
    func currentIndex() -> NSInteger {
        if mainView?.bounds.size.width == 0 || mainView?.bounds.size.height == 0 {
            return 0
        }
        let index = ((mainView?.contentOffset.x)! + (flowLayout?.itemSize.width)! * 0.5) / (flowLayout?.itemSize.width)!
        return NSInteger(max(index, 0))
    }
    
    func pageControlIndexWithCurrentCellIndex(index: NSInteger) -> NSInteger {
        return NSInteger(index % imagePathsGroup.count)
    }
}
