//
//  BaseNavigationController.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/13.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        viewController.hidesBottomBarWhenPushed = true
    }

}
