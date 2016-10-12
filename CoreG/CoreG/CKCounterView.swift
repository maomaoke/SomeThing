//
//  CKCounterView.swift
//  CoreG
//
//  Created by 钰龙徐 on 2016/10/12.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

import UIKit

let π: CGFloat = CGFloat(M_PI)
let numOfGlassess = 8

@IBDesignable class CKCounterView: UIView {

    @IBInspectable var counter: Int = 5 {
        didSet {
            if counter <= numOfGlassess {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var outlineColor = UIColor.blue
    
    @IBInspectable var counterColor = UIColor.orange
    
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        
        let beginRadian = π * 3 / 4
        var endRadian = π / 4
        
        let radius = max(rect.width, rect.height)
        let arcWidth: CGFloat = 76
        let processLineWidth: CGFloat = 3;
        var bezierPath = UIBezierPath(arcCenter: center, radius: (radius - arcWidth) * 0.5, startAngle: beginRadian, endAngle: endRadian, clockwise: true)
        bezierPath.lineWidth = arcWidth
        counterColor.set()
        bezierPath.stroke()
        
        
        //弧
        let radianLength = (2 * π - beginRadian + endRadian) * CGFloat(counter) / CGFloat(numOfGlassess)
        endRadian = radianLength - 2 * π + beginRadian
    
        bezierPath = UIBezierPath(arcCenter: center, radius: (radius - processLineWidth) * 0.5, startAngle: beginRadian, endAngle: endRadian, clockwise: true)
        
        bezierPath.addArc(withCenter: center, radius: radius * 0.5 - arcWidth, startAngle: endRadian, endAngle: beginRadian, clockwise: false)
        
        bezierPath.close()
        bezierPath.lineWidth = processLineWidth
        UIColor.black.set()
        bezierPath.stroke()
    }
}
