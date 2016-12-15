//
//  ImageViewExtension.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/15.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(_ urlString: String?, placeHolder: String? = nil) {
        guard let urlString = urlString  else {
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var placeHolderImage: UIImage?
        if let placeHolder = placeHolder {
            placeHolderImage = UIImage(named: placeHolder)
        }
        
        kf.setImage(with: url, placeholder: placeHolderImage)
    }
}
