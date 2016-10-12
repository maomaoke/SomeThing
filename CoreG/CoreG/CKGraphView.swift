//
//  CKGraphView.swift
//  CoreG
//
//  Created by 钰龙徐 on 2016/10/12.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

import UIKit

@IBDesignable class CKGraphView: UIView {

    @IBInspectable var startColor = UIColor.red
    
    @IBInspectable var endColor = UIColor.green
    override func draw(_ rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor, endColor.cgColor]
        //色域
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLoactions: [CGFloat] = [0.0, 1.0]
        //渐变色
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLoactions)
        //颜色起始位置
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: rect.height)
        
        ctx?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
    }
}
