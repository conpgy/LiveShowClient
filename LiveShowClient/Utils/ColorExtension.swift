//
//  ColorExtension.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/27.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }
    
}
