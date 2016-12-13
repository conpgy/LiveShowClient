//
//  RankDetailViewController.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/13.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit

class RankDetailViewController: UIViewController {

    let rankType: RankType
    
    
    init(rankType: RankType) {
        self.rankType = rankType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init invalid")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        for index in 0..<14 {
            let detailVc = RankDetailViewController(rankType: RankType.parse(with: index)!)
            self.addChildViewController(detailVc)
        }
        
    }

}
