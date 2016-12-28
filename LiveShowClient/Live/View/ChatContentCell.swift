//
//  ChatContentCell.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/28.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit
import SnapKit

class ChatContentCell: UITableViewCell {

    var messageLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        messageLabel = UILabel()
//        messageLabel.font = UIFont.systemFont(ofSize: 13)
//        messageLabel.textColor = UIColor.white
        contentView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
