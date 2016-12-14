//
//  RankDetailCell.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/14.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit
import Kingfisher

class RankDetailCell: UITableViewCell {
    
    var rankNoButton: UIButton!
    var avatarImageView: UIImageView!
    var nicknameLabel: UILabel!
    var liveImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 排名
    var rankNo: Int = 0 {
        didSet {
            if rankNo < 3 {
                rankNoButton.setTitle("", for: .normal)
                rankNoButton.setImage(UIImage(named: "ranking_icon_no\(rankNo + 1)"), for: .normal)
            } else {
                rankNoButton.setImage(nil, for: .normal)
                rankNoButton.setTitle("\(rankNo + 1)", for: .normal)
            }
        }
    }
    
    var rankModel: RankModel? {
        didSet {
            nicknameLabel.text = rankModel?.nickname
            
            if let rankModel = rankModel {
                liveImageView.isHidden = !rankModel.isInLive
                avatarImageView.kf.setImage(with: URL(string: rankModel.avatar))
            } else {
                liveImageView.isHidden = true
                avatarImageView.kf.setImage(with: nil)
            }

        }
    }

    
    func setupSubViews() {
        rankNoButton = UIButton()
        rankNoButton.isUserInteractionEnabled = false
        rankNoButton.frame = CGRect(x: 20, y: 15, width: 25, height: 30)
        rankNoButton.setTitleColor(UIColor.black, for: .normal)
        rankNoButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(rankNoButton)
        
        avatarImageView = UIImageView(frame: CGRect(x: rankNoButton.frame.maxX + 20, y: 12, width: 36, height: 36))
        avatarImageView.layer.cornerRadius = 18
        avatarImageView.layer.masksToBounds = true
        contentView.addSubview(avatarImageView)
        
        nicknameLabel = UILabel()
        nicknameLabel.textColor = UIColor.black
        nicknameLabel.font = UIFont.systemFont(ofSize: 13)
        nicknameLabel.frame = CGRect(x: avatarImageView.frame.maxX + 10, y: avatarImageView.frame.minY + 10, width: 120, height: 20)
        contentView.addSubview(nicknameLabel)
        
        liveImageView = UIImageView(frame: CGRect(x: Const.screenWidth - 25 - 20, y: 20, width: 25, height: 15))
        liveImageView.image = UIImage(named: "center_icon_follow_zhibo")
        liveImageView.isHidden = true
        contentView.addSubview(liveImageView)
    }
    
}
