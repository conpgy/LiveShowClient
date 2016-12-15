//
//  WaterFlowLayout.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/15.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit

protocol WaterFlowLayoutDataSource: class {
    func waterFlowLayout(_ layout: WaterFlowLayout, heightAt indexPath: IndexPath) -> CGFloat
    func numberOfColumns(in layout: WaterFlowLayout) -> Int
}

class WaterFlowLayout: UICollectionViewFlowLayout {
    
    weak var dataSource: WaterFlowLayoutDataSource?
    
    // item attributes
    fileprivate lazy var attributesArray = [UICollectionViewLayoutAttributes]()
    
    // contentView height
    fileprivate var contentViewHeight: CGFloat = 0
    
    // column min heights dictionary
    fileprivate lazy var columnMinHeights: [CGFloat] = {
        let columns = self.dataSource?.numberOfColumns(in: self) ?? 1
        return Array(repeating: self.sectionInset.top, count: columns)
    }()
    
    // collection view item has initlized index
    fileprivate var indexOfItemAlreadySet = 0

}

extension WaterFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let dataSouce = self.dataSource else {
            return
        }
        
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        var columns: Int = dataSouce.numberOfColumns(in: self)
        if columns <= 0 {
            columns = 1
        }
        
        // compute the item width
        let itemWidth = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat(columns-1) * minimumLineSpacing) / CGFloat(columns)
        
        // setup the item attributes
        for index in indexOfItemAlreadySet..<itemCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributesArray.append(attrs)
            
            // get the item height
            let itemHeight = dataSouce.waterFlowLayout(self, heightAt: indexPath)
            
            // update min column height
            var minHeight = columnMinHeights.min()!
            let column = columnMinHeights.index(of: minHeight)!
            minHeight += itemHeight + minimumLineSpacing
            columnMinHeights[column] = minHeight
            
            // setup the item frame
            attrs.frame = CGRect(
                x: sectionInset.left + (minimumLineSpacing+itemWidth) * CGFloat(column),
                y: minHeight - itemHeight - minimumInteritemSpacing,
                width: itemWidth,
                height: itemHeight
            )
        }
        
        contentViewHeight = columnMinHeights.max()! + sectionInset.bottom - minimumInteritemSpacing
        indexOfItemAlreadySet = itemCount
    }
}

extension WaterFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: contentViewHeight)
    }
}
