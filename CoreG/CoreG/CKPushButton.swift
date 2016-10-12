//
//  CKPushButton.swift
//  CoreG
//
//  Created by 钰龙徐 on 2016/10/12.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

import UIKit

@IBDesignable class CKPushButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.white
    
    @IBInspectable var isAddButton: Bool = true
    
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        bezierPath.fill()
        
        let plusHeight: CGFloat = 3.0
        let pluswidth: CGFloat = min(rect.width, rect.height) * 0.6
        
        let plusPath = UIBezierPath()
        plusPath.lineWidth = plusHeight
        UIColor.white.set()
        
        plusPath.move(to: CGPoint(x: (rect.width - pluswidth) * 0.5,
                                  y: rect.height * 0.5))
        plusPath.addLine(to: CGPoint(x: (rect.width + pluswidth) * 0.5,
                                     y: rect.height * 0.5))
        plusPath.stroke()
        
        if isAddButton {
            plusPath.move(to: CGPoint(x: rect.width * 0.5,
                                      y: (rect.height - pluswidth) * 0.5))
            plusPath.addLine(to: CGPoint(x: rect.width * 0.5,
                                         y: (rect.height + pluswidth) * 0.5))
            plusPath.stroke()
        }
    }
}
