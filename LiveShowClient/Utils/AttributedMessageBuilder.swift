//
//  AttributedMessageBuilder.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/28.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit
import Kingfisher

class AttributedMessageBuilder {
}

extension AttributedMessageBuilder {
    
    func joinRoom(with userName: String) -> NSAttributedString {
        
        let message = userName + " 进入房间"
        let attriMessage = NSMutableAttributedString(string: message, attributes: [NSForegroundColorAttributeName: UIColor.white])
        
        let range = NSRange(location: 0, length: userName.characters.count)
        attriMessage.setAttributes([NSForegroundColorAttributeName: UIColor.orange], range: range)
        
        return attriMessage
    }
    
    func build(with content: String, userName: String) -> NSAttributedString {
        
        let message = "\(userName) : \(content)"
        
        let attriMessage = NSMutableAttributedString(string: message, attributes: [NSForegroundColorAttributeName: UIColor.white])
        
        let userRange = NSRange(location: 0, length: userName.characters.count)
        attriMessage.setAttributes([NSForegroundColorAttributeName: UIColor.orange], range: userRange)
        
        // match emoticon
        let pattern = "\\[.*?\\]"
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return attriMessage
        }
        
        let matchResults = regex.matches(in: message, options: [], range: NSRange(location: userRange.length, length: message.characters.count - userRange.length))
        
        for i in (0..<matchResults.count).reversed() {
            
            let result = matchResults[i]
            
            let imageName = (content as NSString).substring(with: result.range)
            guard let image = UIImage(named: imageName) else {
                continue
            }
            
            let font = UIFont.systemFont(ofSize: 13)
            let attachment = NSTextAttachment()
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let imageAttri = NSAttributedString(attachment: attachment)
            
            attriMessage.replaceCharacters(in: result.range, with: imageAttri)
        }
        
        return attriMessage
    }
    
    func build(with giftName: String, giftUrl: String, userName: String) -> NSAttributedString {
        
        let message = "\(userName) 送 \(giftName) "
        let attriMessage = NSMutableAttributedString(string: message, attributes: [NSForegroundColorAttributeName: UIColor.white])
        
        let userRange = NSRange(location: 0, length: userName.characters.count)
        attriMessage.setAttributes([NSForegroundColorAttributeName: UIColor.orange], range: userRange)
        
        // gift name color
        let giftRange = (message as NSString).range(of: giftName)
        attriMessage.setAttributes([NSForegroundColorAttributeName: UIColor(r: 102, g: 255, b: 255)], range: giftRange)
        
        // gift image
        guard let image = KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: giftUrl) else {
            return attriMessage
        }
        
        let attachment = NSTextAttachment()
        attachment.image = image
        let font = UIFont.systemFont(ofSize: 13)
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let giftAttriString = NSAttributedString(attachment: attachment)
        attriMessage.append(giftAttriString)
        
        return attriMessage
    }
    
}
