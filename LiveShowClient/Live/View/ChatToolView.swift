//
//  ChatToolView.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/27.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit

protocol ChatToolViewDelegate: class {
    func chatToolView(_ toolView: ChatToolView, message: String)
}

class ChatToolView: UIView {

    fileprivate lazy var emtionView: EmotionPanel = EmotionPanel(frame: CGRect(x: 0, y: 0, width: Const.screenWidth, height: 216))
    
    fileprivate var switchEmotionButton: UIButton!
    var textField: UITextField!
    fileprivate var sendButton: UIButton!
    
    weak var delegate: ChatToolViewDelegate?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setupUI() {
        
        sendButton = UIButton(type: .system)
        sendButton.frame = CGRect(x: self.frame.maxX - 65, y: 5, width: 60, height: self.frame.height - 10)
        sendButton.setTitle("发送", for: .normal)
        sendButton.setTitleColor(UIColor.white, for: .normal)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        sendButton.layer.cornerRadius = 3
        sendButton.backgroundColor = UIColor(r:214, g: 134, b: 67)
        sendButton.addTarget(self, action: #selector(sendButtonClick), for: .touchUpInside)
        addSubview(sendButton)
        
        switchEmotionButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        switchEmotionButton.setImage(UIImage(named: "chat_btn_emoji"), for: .normal)
        switchEmotionButton.setImage(UIImage(named: "chat_btn_keyboard"), for: .selected)
        switchEmotionButton.addTarget(self, action: #selector(switchEmotionButtonClick), for: .touchUpInside)
        
        textField = UITextField(frame: CGRect(x: 5, y: 5, width: sendButton.frame.origin.x - 10, height: sendButton.frame.height))
        addSubview(textField)
        textField.rightView = switchEmotionButton
        textField.rightViewMode = .always
        textField.allowsEditingTextAttributes = true

    }
    
}

extension ChatToolView {
    
    @objc func switchEmotionButtonClick() {
        switchEmotionButton.isSelected = !switchEmotionButton.isSelected
    }
    
    @objc func sendButtonClick() {
        
        let inputText = textField.text ?? ""
        if inputText.characters.count == 0 {
            return
        }
        
        delegate?.chatToolView(self, message: inputText)
        
        textField.text = nil
    }
}
