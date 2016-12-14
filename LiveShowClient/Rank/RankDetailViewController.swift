//
//  RankDetailViewController.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/13.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit
import Alamofire

class RankDetailViewController: UIViewController {

    let rankType: RankType
    let detailBounds: CGRect
    
    var tableView: UITableView!
    
    lazy var rankModelList = [RankModel]()
    
    init(rankType: RankType, detailBounds: CGRect) {
        self.rankType = rankType
        self.detailBounds = detailBounds
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init invalid")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        // 加载数据
        loadData()
    }
    
    func initUI() {
        tableView = UITableView(frame: detailBounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        view.addSubview(tableView)
    }
    
    func loadData() {

        let url: String
        let subRankValue: Int
        switch rankType {
        case let .Star(subRank):
            url = Const.rankStarUrl
            subRankValue = subRank.rawValue
        case let .Wealth(subRank):
            url = Const.rankWealthUrl
            subRankValue = subRank.rawValue
        case let .Popularity(subRank):
            url = Const.rankPopularityUrl
            subRankValue = subRank.rawValue
        case let .Week(subRank):
            url = Const.rankAllUrl
            subRankValue = subRank.rawValue
        }
        
        let params = ["pageSize": 30, "type": subRankValue]
        print("url:\(url);  params:\(params)")
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let msgDict = resultDict["message"] as? [String : Any] else { return }
            guard let dataArray = msgDict[self.rankType.title] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                self.rankModelList.append(RankModel(dict: dict))
            }
        
            self.tableView.reloadData()
        }
    }

}

extension RankDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "rankDetailCellID") as? RankDetailCell
        if cell == nil {
            cell = RankDetailCell(style: .subtitle, reuseIdentifier: "rankDetailCellID")
        }
        
        let rankModel = rankModelList[indexPath.row]
        cell?.rankNo = indexPath.row
        cell?.rankModel = rankModel
        
        return cell!
    }
}

extension RankDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
