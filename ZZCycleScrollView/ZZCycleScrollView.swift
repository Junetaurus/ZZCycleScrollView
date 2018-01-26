//
//  ZZCycleScrollView.swift
//  ZZCycleScrollView
//
//  Created by Zhang on 2018/1/12.
//  Copyright © 2018年 LuckyDog. All rights reserved.
//

import UIKit

enum ZZCycleScrollViewPageContolAliment {
    case ZZCycleScrollViewPageContolAlimentRight
    case ZZCycleScrollViewPageContolAlimentCenter
}

enum ZZCycleScrollViewPageContolStyle {
    case ZZCycleScrollViewPageContolStyleClassic
    case ZZCycleScrollViewPageContolStyleNone
}

protocol ZZCycleScrollViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: ZZCycleScrollView, didSelectItemAtIndex index: NSInteger)   -> Void
    
    func cycleScrollView(_ cycleScrollView: ZZCycleScrollView, didScrollToIndex index: NSInteger)   -> Void
}

let CellId: String = "cell"

class ZZCycleScrollView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// delegate
    var delegate: ZZCycleScrollViewDelegate?
    
    /// 网络图片 url string 数组
    var imageURLStringsGroup: NSArray = NSArray.init() {
        didSet {
            
        }
    }
    
    /// 是否无限循环,默认true
    var infiniteLoop: Bool = true {
        didSet {
            
        }
    }
    
    /// 是否自动滚动,默认true
    var autoScroll: Bool = true {
        didSet {
            
        }
    }
    
    var mainView: UICollectionView?
    var controller: UIPageControl?
    var timer: Timer = {
        let time: Timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(automaticScroll), userInfo: nil, repeats: true)
        return time
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initMainView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// mainView
    func initMainView() -> Void {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 0
        mainView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        mainView?.backgroundColor = UIColor.clear
        mainView?.isPagingEnabled = true
        mainView?.showsVerticalScrollIndicator = false
        mainView?.showsHorizontalScrollIndicator = false
        mainView?.register(ZZCollectionViewCell.classForCoder(), forCellWithReuseIdentifier:CellId)
        mainView?.delegate = self;
        mainView?.dataSource = self;
        self.addSubview(mainView!)
    }
    
    @objc func automaticScroll() -> Void {
        
    }
    
    //MARK:UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLStringsGroup.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ZZCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath) as! ZZCollectionViewCell
        return cell
    }
}
