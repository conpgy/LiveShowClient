//
//  AnchorCell.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/15.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class AnchorCell: UICollectionViewCell {
    
    var pictureImageView: UIImageView!
    var liveImageView: UIImageView!
    var nicknameLabel: UILabel!
    var focusButton: UIButton!
    
    var anchorViewModel: HomeAnchorViewModel? {
        didSet {
            guard let vm = anchorViewModel else {
                return
            }
            
            nicknameLabel.text = vm.anchor.name
            liveImageView.isHidden = !vm.anchor.isLive
            focusButton.setTitle("\(vm.anchor.focus)", for: .normal)
            pictureImageView.kf.setImage(with: URL(string: (vm.isEven ? vm.anchor.pic74 : vm.anchor.pic51)))
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        
        
        let padding: CGFloat = 5
        
        pictureImageView = UIImageView()
        pictureImageView.backgroundColor = UIColor.gray
        pictureImageView.contentMode = .scaleAspectFill
        contentView.addSubview(pictureImageView)
        pictureImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        liveImageView = UIImageView()
        liveImageView.image = UIImage(named: "home_icon_live")
        liveImageView.isHidden = true
        contentView.addSubview(liveImageView)
        liveImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 23, height: 13))
            make.top.equalTo(padding)
            make.right.equalTo(-padding)
        }
        
        nicknameLabel = UILabel()
        nicknameLabel.textColor = UIColor.white
        nicknameLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(nicknameLabel)
        nicknameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(padding)
            make.bottom.equalTo(-padding)
        }
        
        focusButton = UIButton()
        focusButton.isUserInteractionEnabled = false
        focusButton.setImage(UIImage(named:"home_icon_people"), for: .normal)
        focusButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        focusButton.setTitleColor(UIColor.white, for: .normal)
        contentView.addSubview(focusButton)
        focusButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.nicknameLabel.snp.right).offset(padding)
            make.centerY.equalTo(self.nicknameLabel.snp.centerY)
        }
    }
}
