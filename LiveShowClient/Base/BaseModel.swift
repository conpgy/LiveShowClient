//
//  BaseModel.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/14.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
