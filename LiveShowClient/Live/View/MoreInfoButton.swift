//
//  MoreInfoButton.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/16.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit

class MoreInfoButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView?.contentMode = .scaleAspectFit
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let ratio : CGFloat = 0.5
        imageView?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height * ratio)
        titleLabel?.frame = CGRect(x: 0, y: imageView!.frame.maxY, width: frame.width, height: frame.height * (1 - ratio))
    }

}
