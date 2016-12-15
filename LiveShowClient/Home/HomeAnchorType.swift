//
//  HomeAnchorType.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/15.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import Foundation

enum HomeAnchorType: Int {
    case All = 0
    case Idol = 1
    case GoodVoice = 2
    case Talent = 4
    case YoungHunk = 5
    case HighBeauty = 6
    case Hot = 7
    case Funny = 8
    case More = 3
    
}


extension HomeAnchorType {
    var title: String {
        switch self {
        case .All:
            return "全部"
        case .Idol:
            return "偶像派"
        case .GoodVoice:
            return "好声音"
        case .Talent:
            return "有才艺"
        case .YoungHunk:
            return "小鲜肉"
        case .HighBeauty:
            return "高颜值"
        case .Hot:
            return "劲爆"
        case .Funny:
            return "搞笑"
        case .More:
            return "还有更多"
        }
    }
}
