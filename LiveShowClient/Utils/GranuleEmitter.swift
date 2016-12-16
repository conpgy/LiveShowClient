//
//  GranuleEmitter.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/16.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit

class GranuleEmitter {
    static let sharedInstance = GranuleEmitter()
    
    fileprivate lazy var emitterLayer: CAEmitterLayer = {
        let emitterLayer = CAEmitterLayer()
        
        emitterLayer.emitterPosition = CGPoint(x: 335, y: 637)
        emitterLayer.emitterSize = CGSize(width: 20, height: 20)
        emitterLayer.renderMode = kCAEmitterLayerUnordered
        emitterLayer.preservesDepth = true
        
        var cells = [CAEmitterCell]()
        for i in 0..<10 {
            let cell = CAEmitterCell()
            cell.birthRate = 1
            cell.lifetime = Float(arc4random_uniform(4) + 1)
            cell.lifetimeRange = 1.5
            
            let image = UIImage(named: "good\(i)_30x30")
            cell.contents = image?.cgImage
            cell.velocity = CGFloat(arc4random_uniform(100) + 100)
            cell.velocityRange = 80
            cell.emissionLongitude = CGFloat(M_PI + M_PI_2)
            cell.emissionRange = CGFloat(M_PI_2/6)
            cell.scale = 0.7
            cells.append(cell)
        }
        
        emitterLayer.emitterCells = cells
        
        return emitterLayer
    }()
}

extension GranuleEmitter {
    
    func emitGranules(on view: UIView) {
        view.layer.addSublayer(emitterLayer)
    }
    
    func stop() {
        emitterLayer.removeFromSuperlayer()
    }
}
