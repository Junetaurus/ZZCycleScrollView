//
//  ZZCollectionViewCell.swift
//  ZZCycleScrollView
//
//  Created by Zhang on 2018/1/12.
//  Copyright © 2018年 LuckyDog. All rights reserved.
//

import UIKit

class ZZCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView? = nil
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView.init()
        self.contentView.addSubview(imageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = self.bounds
    }
}
