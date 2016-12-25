//
//  ChatService.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/25.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import Foundation


class ChatService {
    
    static let sharedInstance = ChatService()
    
    fileprivate var clientSocket: Socket?
    
    fileprivate let queue = DispatchQueue(label: "com.onejiall.chatService")
    
    init() {
        
    }
    
    func connectChatServer() {
        
        queue.async { [unowned self] in
            
            if let socket = self.clientSocket, socket.isConnected {
                return
            }
            
            do {
                try self.clientSocket = Socket.create()
                
                guard let socket = self.clientSocket else {
                    print("Unable to unwrap client socket...")
                    return
                }
                
                try socket.connect(to: Const.chatHost, port: Const.chatPort)
                
                print("socket connected status: \(socket.isConnected)")
                
                
                var readData = Data(capacity: 4096)
                
                repeat {
                    
                    let byteRead = try socket.read(into: &readData)
                    
                    if byteRead > 0 {
                        
                        guard let message = String(data: readData, encoding: .utf8) else {
                            print("Error decoding response...")
                            readData.count = 0
                            break
                        }
                        
                        print(message)
                    }
                    
                } while socket.isConnected
                
                
            } catch let error {
                print("could not connect chat server. \(error.localizedDescription)")
            }
        }

    }
    
    func disconnectChatServer() {
        closeSocket()
    }
    
    
    private func closeSocket() {
        
        guard let socket = clientSocket else {
            return
        }
        socket.close()
        clientSocket = nil
    }
    
    func sendMessage(_ message: String) {
        
        guard let socket = self.clientSocket, socket.isConnected else {
            print("Can not send message. Chat Server has not connected.")
            return
        }
        
        do {
            
            try socket.write(from: message)
            
        } catch let error {
            
            print("write message to chat server failed... \(error)")
            
        }
 
    }
}
