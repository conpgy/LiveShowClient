//
//  RoomViewController.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/14.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit
import IJKMediaFramework

class RoomViewController: UIViewController {
    
    var anchor: Anchor?
    
    fileprivate var backgroundImageView: UIImageView!
    fileprivate var iconImageView: UIImageView!
    fileprivate var focusView: UIView!
    fileprivate var onlineView: UIView!
    fileprivate var contributeView: UIView!
    
    fileprivate var liveUrl: String?
    
    fileprivate var player: IJKFFMoviePlayerController?

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        loadRoomInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        player?.shutdown()
    }
    
    private func initUI() {
        setupBackgroundImageView()
        setupCloseButton()
        setupFocusView()
        setupOnlineView()
        setupContributeView()
        setupBottomStackView()
    }
    
    private func setupBackgroundImageView() {
        backgroundImageView = UIImageView(frame: view.bounds)
        view.addSubview(backgroundImageView)
        backgroundImageView.setImage(anchor?.pic74)
        setupBlurView()
    }
    
    private func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = backgroundImageView.bounds
        backgroundImageView.addSubview(blurView)
    }
    
    private func setupCloseButton() {
        let closeButton = UIButton(frame: CGRect(x: Const.screenWidth - 50 - 10, y: 20, width: 50, height: 50))
        closeButton.setImage(UIImage(named: "menu_btn_close"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonClick), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    private func setupFocusView() {
        focusView = UIView()
        focusView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        focusView.layer.cornerRadius = 3
        view.addSubview(focusView)
        focusView.snp.makeConstraints { (make) in
            make.height.equalTo(32)
            make.top.equalTo(30)
            make.left.equalTo(10)
        }
        
        let iconImageView = UIImageView()
        iconImageView.setImage(anchor?.pic51)
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = 13
        iconImageView.layer.masksToBounds = true
        focusView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 26, height: 26))
            make.left.equalTo(5)
            make.top.equalTo(3)
        }
        
        // anchor nickname
        let nicknameLabel = UILabel()
        nicknameLabel.font = UIFont.boldSystemFont(ofSize: 11)
        nicknameLabel.textColor = UIColor.white
        focusView.addSubview(nicknameLabel)
        nicknameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(3)
            make.left.equalTo(iconImageView.snp.right).offset(8)
        }
        nicknameLabel.text = anchor?.name

        // room number
        let roomNumberLabel = UILabel()
        roomNumberLabel.font = UIFont.systemFont(ofSize: 9)
        roomNumberLabel.textColor = UIColor.white
        focusView.addSubview(roomNumberLabel)
        roomNumberLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-3)
            make.left.equalTo(nicknameLabel.snp.left)
        }
        roomNumberLabel.text = "房间号: \(anchor?.roomId ?? "")"
        
        // focus button
        let focusButton = UIButton(type: .system)
        focusButton.setTitle("关注", for: .normal)
        focusButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        focusButton.setTitleColor(UIColor.white, for: .normal)
        focusButton.backgroundColor = UIColor(red: 214/255.0, green: 134/255.0, blue: 67/255.0, alpha: 1)
        focusButton.layer.cornerRadius = 2
        focusView.addSubview(focusButton)
        focusButton.addTarget(self, action: #selector(focusButtonClick), for: .touchUpInside)
        focusButton.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.left.equalTo(roomNumberLabel.snp.right).offset(15)
            make.right.equalTo(-5)
        }
    }
    
    private func setupOnlineView() {
        onlineView = UIView()
        onlineView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        onlineView.layer.cornerRadius = 3
        view.addSubview(onlineView)
        
        let onlineDescLabel = UILabel()
        onlineDescLabel.font = UIFont.systemFont(ofSize: 10)
        onlineDescLabel.textColor = UIColor(red: 214/255.0, green: 134/255.0, blue: 67/255.0, alpha: 1)
        onlineDescLabel.text = "在线"
        onlineView.addSubview(onlineDescLabel)
        
        let onlineLabel = UILabel()
        onlineLabel.font = UIFont.systemFont(ofSize: 10)
        onlineLabel.textColor = UIColor.white
        onlineLabel.text = "\(anchor?.focus ?? 0)"
        onlineView.addSubview(onlineLabel)
        
        
        onlineView.snp.makeConstraints { (make) in
            make.top.equalTo(self.focusView.snp.bottom).offset(5)
            make.left.equalTo(self.focusView.snp.left)
            make.bottom.equalTo(onlineDescLabel.snp.bottom).offset(5)
            make.right.equalTo(onlineLabel.snp.right).offset(5)
        }
        onlineDescLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(5)
        }
        onlineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(onlineDescLabel.snp.top)
            make.left.equalTo(onlineDescLabel.snp.right).offset(5)
        }
        
    }
    
    private func setupContributeView() {
        contributeView = UIView()
        contributeView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        contributeView.layer.cornerRadius = 3
        view.addSubview(contributeView)
        
        let contributeDescLabel = UILabel()
        contributeDescLabel.font = UIFont.systemFont(ofSize: 10)
        contributeDescLabel.textColor = UIColor(red: 214/255.0, green: 134/255.0, blue: 67/255.0, alpha: 1)
        contributeDescLabel.text = "贡献"
        contributeView.addSubview(contributeDescLabel)
        
        let contributeLabel = UILabel()
        contributeLabel.font = UIFont.systemFont(ofSize: 10)
        contributeLabel.textColor = UIColor.white
        contributeLabel.text = "382932"
        contributeView.addSubview(contributeLabel)
        
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "zhibo_icon_arrow")
        contributeView.addSubview(arrowImageView)
        
        
        contributeView.snp.makeConstraints { (make) in
            make.top.equalTo(self.onlineView.snp.top)
            make.left.equalTo(self.onlineView.snp.right).offset(5)
            make.bottom.equalTo(contributeDescLabel.snp.bottom).offset(5)
            make.right.equalTo(arrowImageView.snp.right).offset(5)
        }
        contributeDescLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(5)
        }
        contributeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contributeDescLabel.snp.top)
            make.left.equalTo(contributeDescLabel.snp.right).offset(5)
        }
        arrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contributeLabel.snp.centerY)
            make.left.equalTo(contributeLabel.snp.right).offset(5)
        }
        
    }
    
    private func setupBottomStackView() {
        
        let stackView = UIStackView(frame: CGRect(x: 0, y: Const.screenHeight - 50, width: Const.screenWidth, height: 50))
        view.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.alignment = .fill
        
        
        let images = ["room_btn_chat", "menu_btn_share", "room_btn_gift", "room_btn_more", "room_btn_qfstar"]
        let selectors = [#selector(chatButtonClick), #selector(shareButtonClick), #selector(giftButtonClick), #selector(moreButtonClick), #selector(starButtonClick)]
        for i in 0...4 {
            let button = UIButton()
            button.setImage(UIImage(named: images[i]), for: .normal)
            button.addTarget(self, action: selectors[i], for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

}

extension RoomViewController {
    
    @objc fileprivate func closeButtonClick() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func focusButtonClick() {
        
    }
    
    @objc fileprivate func starButtonClick(button: UIButton) {
        button.isSelected = !button.isSelected
        button.isSelected ? GranuleEmitter.sharedInstance.emitGranules(on: view) : GranuleEmitter.sharedInstance.stop()
    }
    
    @objc fileprivate func chatButtonClick(button: UIButton) {
        
    }
    
    @objc fileprivate func shareButtonClick(button: UIButton) {
        
    }
    
    @objc fileprivate func giftButtonClick(button: UIButton) {
        
    }
    
    @objc fileprivate func moreButtonClick(button: UIButton) {
        
    }
}

extension RoomViewController {
    fileprivate func loadRoomInfo() {
        guard let roomId = anchor?.roomId, let uid = anchor?.uid else {
            return
        }
        let params:[String: Any] = ["roomId": roomId, "uid": uid]
        Alamofire.request(Const.liveUrl, method: .get, parameters: params).responseString { (response) in
            self.liveUrl = response.result.value
            self.livePlay()
        }
    }
    
    
    // live play
    fileprivate func livePlay() {
        
        // close the debug log
        IJKFFMoviePlayerController.setLogReport(false)
        
        // init the player
        guard let liverUrl = self.liveUrl else {
            return
        }
        
        let url = URL(string: liverUrl)
        player = IJKFFMoviePlayerController(contentURL: url, with: nil)
        guard let player = self.player else {
            return
        }
        
        
        if anchor?.push == 1 {
            player.view.frame = CGRect(x: 0, y: 150, width: Const.screenWidth, height: Const.screenWidth * 3/4)
        } else {
            player.view.frame = view.bounds
        }
        
        backgroundImageView.insertSubview(player.view, at: 1)
        
        // player
        DispatchQueue.global().async {
            player.prepareToPlay()
            player.play()
        }
    }
}
