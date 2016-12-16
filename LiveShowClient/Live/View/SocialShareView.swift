//
//  SocialShareView.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/16.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit

class SocialShareView: UIView {
    
    var shareButtons = [MoreInfoButton]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupSubViews() {
        let descLabel = UILabel()
        descLabel.textAlignment = .center
        descLabel.font = UIFont.systemFont(ofSize: 15)
        descLabel.textColor = UIColor.white
        descLabel.text = "分享至"
        addSubview(descLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.alignment = .fill
        addSubview(stackView)
        
        let topStackView = shareButtonStackView(shareTypes: [.WechatMoment, .WechatFriend, .Weibo])
        let bottomStackView = shareButtonStackView(shareTypes: [.QQ, .QZone, .CopyLink])
        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(bottomStackView)
        

        descLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(10)
            make.height.equalTo(18)
        }
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-20)
        }
        
    }
    
    private func shareButtonStackView(shareTypes: [SocialShareType]) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.alignment = .fill
        
        for i in 0..<shareTypes.count {
            let shareType = shareTypes[i]
            let button = MoreInfoButton()
            button.setImage(UIImage(named: shareType.shareIcon()), for: .normal)
            button.setTitle(shareType.title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            stackView.addArrangedSubview(button)
            shareButtons.append(button)
        }
        
        return stackView
    }
    
}

extension SocialShareView {
    func show() {
        
        for btn in shareButtons {
            btn.transform = CGAffineTransform(translationX: 0, y: 200)
        }
        
        for(index,btn) in shareButtons.enumerated() {
            UIView.animate(withDuration: 0.5, delay: 0.25 + Double(index) * 0.02, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
                btn.transform = CGAffineTransform.identity
            }, completion: nil)

        }
    }
}


extension SocialShareType {
    func shareIcon() -> String {
        switch self {
        case .WechatMoment:
            return "share_btn_pyq"
        case .WechatFriend:
            return "share_btn_wechat"
        case .Weibo:
            return "share_btn_weibo"
        case .QQ:
            return "share_btn_qq"
        case .QZone:
            return "share_btn_qzone"
        case .CopyLink:
            return "share_btn_link"
        }
    }
}
