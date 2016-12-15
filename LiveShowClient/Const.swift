//
//  Const.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/14.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit

class Const {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let navigationBarHeight: CGFloat = 64
    static let statusBarHeight: CGFloat = 20
    
    static let domain = "http://192.168.31.147:8092"
    
    // url
    static let rankStarUrl = domain + "/rankStar"
    static let rankWealthUrl = domain + "/rankWealth"
    static let rankPopularityUrl = domain + "/rankPopularity"
    static let rankAllUrl = domain + "/rankAll"
    static let anchorUrl = domain + "/home/anchors"
}
