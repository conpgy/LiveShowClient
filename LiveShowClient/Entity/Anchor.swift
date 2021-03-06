//
//  Anchor.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/15.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import Foundation

struct Anchor {
    
    var uid: String = ""
    
    var roomId: Int = 0
    
    var name: String = ""
    
    var pic51: String = ""
    
    var pic74: String = ""
    
    // is on live
    var isLive = false
    
    var type = 0
    
    var push: Int = 0
    
    // focus count
    var focus: Int = 0
    
    init() {}
    
}

extension Anchor {
    
    init(dict: [String: Any]) {
        if let uid = dict["uid"] as? String {
            self.uid = uid
        }
        
        if let roomId = dict["roomId"] as? Int {
            self.roomId = roomId
        }
        
        if let name = dict["name"] as? String {
            self.name = name
        }
        
        if let pic51 = dict["pic51"] as? String {
            self.pic51 = pic51
        }
        
        if let pic74 = dict["pic74"] as? String {
            self.pic74 = pic74
        }
        
        if let live = dict["live"] as? Bool {
            self.isLive = live
        }
        
        if let push = dict["push"] as? Int {
            self.push = push
        }
        
        if let focus = dict["focus"] as? Int {
            self.focus = focus
        }
        
    }
}
