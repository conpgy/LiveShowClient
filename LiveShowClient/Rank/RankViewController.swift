//
//  RankViewController.swift
//  LiveShow
//
//  Created by penggenyong on 2016/12/12.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit

class RankViewController: UIViewController {
    
    var subRankTitleView: SubRankTitleView!
    var collectionView: UICollectionView!
    
    fileprivate let collectionCellID = "collectionCellID"
    
    fileprivate let rankCount = 14
    
    fileprivate var detailControllers = [RankDetailViewController]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    
    func initUI() {
        
        let subRankHeight: CGFloat = 30
        let collectionViewBounds = CGRect(
            x: 0,
            y: 0,
            width: Const.screenWidth,
            height: Const.screenHeight - Const.navigationBarHeight - subRankHeight
        )
        
        for index in 0..<rankCount {
            let detailVc = RankDetailViewController(rankType: RankType.parse(with: index)!, detailBounds: collectionViewBounds)
            detailControllers.append(detailVc)
            self.addChildViewController(detailVc)
        }
        
        
        subRankTitleView = SubRankTitleView(frame: CGRect(x: 0, y: Const.navigationBarHeight, width: Const.screenWidth, height: subRankHeight))
        view.addSubview(subRankTitleView)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = collectionViewBounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(
            frame: CGRect(x:0, y:subRankTitleView.frame.maxY, width: collectionViewBounds.size.width, height: collectionViewBounds.size.height),
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = UIColor.blue
        collectionView.scrollsToTop = false
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        collectionView.backgroundColor = UIColor.clear
        view.addSubview(collectionView)
    }
    
}

extension RankViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath)
        
        // 移除cell所有内容
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        let detailController = detailControllers[indexPath.item]
        detailController.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(detailController.view)
        
        return cell
    }
}

extension RankViewController: UICollectionViewDelegate {
    
}
