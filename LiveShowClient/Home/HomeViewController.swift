//
//  HomeViewController.swift
//  LiveShow
//
//  Created by 彭根勇 on 2016/12/12.
//  Copyright © 2016年 彭根勇. All rights reserved.
//

import UIKit
import Alamofire


private let edgeMargin: CGFloat = 8
private let anchorCellID = "anchorCellID"

class HomeViewController: UIViewController {
    
    let pageSize = 10

    fileprivate lazy var collectionView: UICollectionView = {
       let layout = WaterFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: edgeMargin, left: edgeMargin, bottom: edgeMargin, right: edgeMargin)
        layout.minimumLineSpacing = edgeMargin
        layout.minimumInteritemSpacing = edgeMargin
        layout.dataSource = self
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AnchorCell.self, forCellWithReuseIdentifier: anchorCellID)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    
    fileprivate var currentHomeAnchorType: HomeAnchorType = HomeAnchorType.All
    
    fileprivate var anchorViewModels = [HomeAnchorViewModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        loadData(type: currentHomeAnchorType.rawValue, start: 0)
    }

    
    private func initUI() {
        view.addSubview(collectionView)
    }
    
    fileprivate func loadData(type:Int, start: Int) {
        
        let params = ["type": type, "start": start, "pageSize": pageSize]
        Alamofire.request(Const.anchorUrl, method: .get, parameters: params).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let message = resultDict["message"] as? String else {
                print("message empty")
                return
            }
            
            
            guard let code = resultDict["code"] as? Int else {
                print("code empty")
                return
            }
            
            guard let anchorsDict = resultDict["anchors"] as? [[String: Any]] else {
                print("anchors error")
                return
            }
            
            print("message: " + message)
            print("code: \(code)")
            
            for (index,dict) in anchorsDict.enumerated() {
                let anchor = Anchor(dict: dict)
                let vm = HomeAnchorViewModel(with: anchor)
                vm.isEven = index % 2 == 0
                self.anchorViewModels.append(vm)
            }
            
            self.collectionView.reloadData()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorViewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: anchorCellID, for: indexPath) as! AnchorCell
        cell.anchorViewModel = anchorViewModels[indexPath.item]
        
        if indexPath.item == anchorViewModels.count - 1 && anchorViewModels.count >= pageSize {
            loadData(type: currentHomeAnchorType.hashValue, start: anchorViewModels.count)
        }
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roomVc = RoomViewController()
        roomVc.anchor = anchorViewModels[indexPath.row].anchor
        navigationController?.pushViewController(roomVc, animated: true)
    }
}

extension HomeViewController: WaterFlowLayoutDataSource {
    
    func numberOfColumns(in layout: WaterFlowLayout) -> Int {
        return 2
    }
    
    func waterFlowLayout(_ layout: WaterFlowLayout, heightAt indexPath: IndexPath) -> CGFloat {
        return indexPath.item % 2 == 0 ? Const.screenWidth * 2/3 : Const.screenWidth * 0.5
    }
}
