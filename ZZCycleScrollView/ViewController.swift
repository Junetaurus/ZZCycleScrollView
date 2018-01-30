//
//  ViewController.swift
//  ZZCycleScrollView
//
//  Created by Zhang on 2018/1/12.
//  Copyright © 2018年 LuckyDog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cycleScrollView: ZZCycleScrollView = ZZCycleScrollView.init(frame: CGRect.init(x: 0, y: 100, width: self.view.bounds.size.width, height: self.view.bounds.size.width * (330.0/600.0)))
        self.view .addSubview(cycleScrollView);
        
        cycleScrollView.localizationImageNamesGroup = NSArray.init(objects: "cycle_01.jpg", "cycle_02.jpg", "cycle_03.jpg", "cycle_04.jpg", "cycle_05.jpg", "cycle_06.jpg", "cycle_07.jpg", "cycle_08.jpg")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

