//
//  FlowUtils.swift
//  FlowEmotion
//
//  Created by 乔文德 on 2016/12/9.
//  Copyright © 2016年 wind. All rights reserved.
//

import UIKit

class FlowUtils: NSObject {
    static let sharedInstance = FlowUtils()
    var imageStr:String?
    
    private override init() {
        super.init()
    }
    
    func addFlowEmotion(view:UIView,imageName:String?) {
        
        //获取图片
        self.imageStr = imageName;
        //构建粒子系统
        if imageStr != nil{
            let layer = getEmotionFlowLayer();
            view.layer.addSublayer(layer)
        }
        
    }
    

    //  get CAEmitterLayer
    func getEmotionFlowLayer() -> CAEmitterLayer {
        //设置粒子范围
        let layer = CAEmitterLayer();
        
        let rect = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        layer.frame = rect
        layer.emitterShape = kCAEmitterLayerRectangle
        layer.emitterPosition = CGPoint.init(x: rect.width/2.0, y: 0)
        layer.emitterSize = CGSize.init(width: rect.width, height: 200)
        layer.renderMode  = kCAEmitterLayerOldestFirst;
        
        //EmitterCells
        let leftCell = createEmitterCell(direction: -20);
        leftCell.name = "leftCell"
        let middleCell = createEmitterCell(direction: 0);
        middleCell.name = "middleCell"
        let rightCell = createEmitterCell(direction: 20);
        rightCell.name = "rightCell"
        
        layer.emitterCells = [leftCell,middleCell,rightCell]
        
        //一段时间之后  消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            
            if layer.superlayer != nil {
                layer.setValue(NSNumber.init(value: 0), forKeyPath: "emitterCells.leftCell.birthRate")
                layer.setValue(NSNumber.init(value: 0), forKeyPath: "emitterCells.middleCell.birthRate")
                layer.setValue(NSNumber.init(value: 0), forKeyPath: "emitterCells.rightCell.birthRate")
                
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        return layer;
    }
    
    // create cell
    func createEmitterCell(direction:Double) -> CAEmitterCell {
        let cell = CAEmitterCell();
        cell.contents = UIImage.init(named: self.imageStr!)!.cgImage
        cell.birthRate = 3
        cell.lifetime = 4
        cell.lifetimeRange = 3.0
        
        cell.yAcceleration = 150.0
        cell.velocity = 100.0
        cell.velocityRange = 0;
        cell.xAcceleration = CGFloat(direction)
        cell.emissionLongitude = CGFloat(M_PI_2)
        cell.emissionRange = CGFloat(M_PI_2)
        
        cell.scale = 0.7
        cell.scaleRange = 0.3
        
        return cell
    }
}
