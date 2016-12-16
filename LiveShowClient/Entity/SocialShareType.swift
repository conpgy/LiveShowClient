//
//  SocialShareType.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/16.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import Foundation

enum SocialShareType {
    case WechatMoment
    case WechatFriend
    case Weibo
    case QQ
    case QZone
    case CopyLink
}

extension SocialShareType {
    var title: String {
        switch self {
        case .WechatMoment:
            return "朋友圈"
        case .WechatFriend:
            return "微信好友"
        case .Weibo:
            return "微博"
        case .QQ:
            return "QQ"
        case .QZone:
            return "QQ空间"
        case .CopyLink:
            return "复制链接"
        }
    }
}
