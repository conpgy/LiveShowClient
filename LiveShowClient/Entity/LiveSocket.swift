//
//  ChatSocket.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/27.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import Dispatch
import Foundation
import SwiftyJSON

enum MessageType: Int {
    case normal = 1
    case joinRoom = 2
    case LeaveRoom = 3
    case gift = 4
}

class LiveSocket {
    
    
    weak var delegate: LiveSocketDelegate?
    
    var socket: Socket? = try? Socket.create()
    
    var isConnected: Bool {
        guard let socket = self.socket else {
            return false
        }
        return socket.isConnected
    }
    
    init() {
        do {
            try socket = Socket.create()
        } catch let error  {
            print("create socket error: \(error.localizedDescription)")
        }
    }
    
    
    func connectToChatServer() {
        
        if isConnected {
            return
        }
        
        guard let socket = self.socket else {
            print("socket is null.")
            return
        }
        
        do {
            try socket.connect(to: Const.chatHost, port: Const.chatPort)
            
        } catch let error {
            print("could not connect chat server. \(error.localizedDescription)")
            return
        }
        
        print("socket connected status: \(self.isConnected)")
        
        
        DispatchQueue.global().async { [unowned self, socket] in
            
            do {

                var readData = Data(capacity: 4096)
                
                repeat {
                    
                    let byteRead = try socket.read(into: &readData)
                    
                    if byteRead > 0 {
                        
                        guard let message = String(data: readData, encoding: .utf8) else {
                            print("Error decoding response...")
                            readData.count = 0
                            break
                        }
                        
                        self.handle(with: message)
                    }
                    
                    readData.count = 0
                    
                } while socket.isConnected
                
            } catch let error {
                print("read error: \(error.localizedDescription)")
            }

        }
    }
    
    func send(joinRoom userName: String) {
        guard let socket = self.socket, socket.isConnected else {
            print("Can not send message. socket has not connected.")
            return
        }
        
        let jsonString = "{\"type\":\(MessageType.joinRoom.rawValue),\"userName\":\"\(userName)\"}"
        send(message: jsonString)
    }
    
    func send(with message: String, userName: String) {
        guard let socket = self.socket, socket.isConnected else {
            print("Can not send message. socket has not connected.")
            return
        }
        
        let jsonString = "{\"type\":\(MessageType.normal.rawValue),\"content\":\"\(message)\",\"userName\":\"\(userName)\"}"
        send(message: jsonString)
        
    }
    
    func giftGiving(with name: String, url: String, userName: String) {
        guard let socket = self.socket, socket.isConnected else {
            print("Can not send message. socket has not connected.")
            return
        }
        
        let jsonString = "{\"type\":\(MessageType.gift.rawValue),\"name\":\"\(name)\",\"url\":\"\(url)\",\"userName\":\"\(userName)\"}"
        send(message: jsonString)
        
    }
    
    private func send(message: String) {
        
        do {
            try self.socket!.write(from: message)
            
        } catch let error {
            
            print("write message to chat server failed... \(error)")
            
        }
    }
    
    func close() {
        guard let socket = self.socket else {
            return
        }
        socket.close()
    }
    
    
    func handle(with message: String?) {
        
        guard let msg = message else {return}
        
//        print("socket handle message: \(msg)")
        
        // json parsing
        let json = JSON.parse(msg)
        
        guard let type = json["type"].int else {
            print("type field not found.")
            return
        }
        
        guard let messageType = MessageType(rawValue: type) else {
            print("type invalid.")
            return
        }
        
        guard let userName = json["userName"].string else {
            print("userName not found.")
            return
        }
        
        
        switch messageType {
        case .normal:
            if let content = json["content"].string, let delegate = self.delegate {
                delegate.socket(self, userName: userName, message: content)
            }
        case .joinRoom:
            if let delegate = self.delegate {
                delegate.socket(self, joinRoom: userName)
            }
        case .gift:
            if let giftName = json["name"].string, let giftUrl = json["url"].string, let delegate = self.delegate {
                delegate.socket(self, userName: userName, giftName: giftName, giftUrl: giftUrl)
            }
        default:
            break
        }
        
    }
}

protocol LiveSocketDelegate: class {
    
    func socket(_ socket: LiveSocket, joinRoom userName: String)
    func socket(_ socket: LiveSocket, userName: String, message: String)
    func socket(_ socket: LiveSocket, userName: String, giftName: String, giftUrl: String)
    func socket(_ socket: LiveSocket, leaveRoom userName: String)
    
}
