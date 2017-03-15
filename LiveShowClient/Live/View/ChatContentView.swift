//
//  ChatContentView.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/28.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit

private let chatContentCellID = "chatContentCellID"

class ChatContentView: UIView {
    
    fileprivate var tableView: UITableView!
    fileprivate var messages = [NSAttributedString]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        addSubview(tableView)
    }
    
    func append(message: NSAttributedString) {
        
        messages.append(message)
        tableView.reloadData()
        
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
}

extension ChatContentView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: chatContentCellID) as? ChatContentCell
        if cell == nil {
            cell = ChatContentCell(style: .default, reuseIdentifier: chatContentCellID)
        }
        
        cell!.messageLabel.attributedText = messages[indexPath.row]
        
        return cell!
        
    }
    
}
